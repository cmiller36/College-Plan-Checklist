class User < ActiveRecord::Base

  validates_presence_of :username, :email, :password
  has_secure_password

  has_many :colleges
  has_many :notes
  
end