class User < ActiveRecord::Base
	has_many :tablets

	#validates :email, presence: true, format: { with: /\A[^@]+@[^@]+\z/ }
	validates :email, presence: true, uniqueness: true, format: { with: /\A[^@]+@[^@]+\z/ }

	def self.generate_secret(a)
		secret_token = 'zapallitos'
    joined_str = [a,secret_token].join('/')
    OpenSSL::Digest::SHA256.new(joined_str.encode('UTF-8')).to_s
  end
end
