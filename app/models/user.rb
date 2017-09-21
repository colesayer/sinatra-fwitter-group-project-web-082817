class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def self.find_by_slug(name)
    @name = name.split("-").join(" ")
    self.find_by(username: @name)
  end

  def slug
    self.username.downcase.split(" ").join("-")
  end


end
