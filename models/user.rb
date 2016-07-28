require 'data_mapper'
require 'dm-postgres-adapter'
require 'bcrypt'

class User
  include DataMapper::Resource
  include BCrypt

  property :id,   Serial
  property :email, String
  property :username, String
  property :password, String

  def set_password(password)
    self.password = Password.create(password)
  end
end
