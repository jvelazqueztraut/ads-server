require 'digest/sha1'

class Tablet < ActiveRecord::Base
  has_one :location
  belongs_to :user

  validates :uuid, presence: true, uniqueness: true

  def self.salt_that_token(unsalted_token, salt)
		return Digest::SHA1.hexdigest([unsalted_token, salt].join('')).to_s # "2aba83b05dc9c2d9db7e5d34e69787d0a5e28fc5"
  end

  def self.generate_secret(a, b) #, c)
		secret_token = 'zapallitos'
    joined_str = [a,b,secret_token].join('/')
    OpenSSL::Digest::SHA256.new(joined_str.encode('UTF-8'))
  end

end
