require 'data_mapper'
require 'dm-postgres-adapter'
require 'bcrypt'

class User
    include DataMapper::Resource
    include BCrypt
    attr_reader :password
    attr_accessor :password_confirmation
    validates_confirmation_of :password
    validates_format_of :email, as: :email_address

    property :id,   Serial
    property :email, String, format: :email_address, required: true
    property :username, String, required: true
    property :password_digest, String, length: 60, required: true

    def password=(password)
      @password = password
      self.password_digest = Password.create(password)
  end
end
