class User < ActiveRecord::Base
  has_many :tweets

  def slug
    self.username.downcase.split(" ").join("-")
  end

end
