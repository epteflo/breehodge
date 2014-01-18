require 'bcrypt'
class User < ActiveRecord::Base
  include BCrypt

  attr_accessor :password, :password_confirmation

  def authenticate(password)
    Password.new(password_hash) == password
  end
end
