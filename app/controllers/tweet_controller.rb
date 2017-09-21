require './config/environment'

class TweetController < ApplicationController

  get '/tweets' do
    if !session[:user_id].nil?
      @tweets = Tweet.all
      erb :"tweets/index"
    else
      redirect to "/login"
    end
  end

  get '/tweets/new' do
    if !session[:user_id].nil?
      erb :"tweets/new"
    else
      redirect to "/login"
    end
  end

  post '/tweets' do
    if params[:content] != ""
      @user = User.find_by(id: session[:user_id])
      @tweet = Tweet.create(params)
      @tweet.user_id = @user.id
      @tweet.save
      redirect to "tweets/#{@tweet.id}"
    else
      redirect to "tweets/new"
    end
  end

  get '/tweets/:id/edit' do
    if !session[:user_id].nil?
      @user = User.find_by(id: session[:user_id])
      @tweet = Tweet.find_by(id: params[:id])
      erb :"tweets/edit"
    else
      redirect to "/login"
    end
  end



  patch '/tweets/:id' do
      if params[:content] == ""
        redirect to "/tweets/#{params[:id]}/edit"
      else
        @tweet = Tweet.find_by(id: params[:id])
        @tweet.update(content: params[:content])
        redirect to "/tweets/#{params[:id]}"
      end
  end





  # get '/tweets/:user_id' do
  #   @user = User.find(params[:user_id])
  #   erb :"tweets/show"
  # end

  get '/tweets/:id' do
    if !session[:user_id].nil?
      @user = User.find_by(id: session[:user_id])
      @tweet = Tweet.find_by(id: params[:id])
      erb :"tweets/show"
    else
      redirect to "/login"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by(params[:id])
    if @tweet.user_id == session[:user_id]
      @tweet.destroy
      redirect to "/tweets"
    else
      redirect to "/tweets/#{@tweet.id}"
    end
  end




end
