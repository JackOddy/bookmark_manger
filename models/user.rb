require 'data_mapper'
require 'dm-postgres-adapter'
require 'bcrypt'

class User
    include DataMapper::Resource
    include BCrypt
    attr_reader :password
    attr_accessor :password_confirmation
    validates_confirmation_of :password

    property :id,   Serial
    property :email, String
    property :username, String
    property :password_digest, String, length: 60

    def password=(password)
      @password = password
      self.password_digest = Password.create(password)
  end
end
