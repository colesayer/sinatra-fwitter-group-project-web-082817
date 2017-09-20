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
    @tweet = Tweet.create(params)

  end

  get '/tweets/:user_id' do
    @user = User.find(params[:user_id])
    erb :"tweets/show"
  end

end
