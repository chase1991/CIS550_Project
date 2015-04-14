class User < ActiveRecord::Base

	validates :username, presence: true, uniqueness: {case_sensitive: true}
	validates :email, presence: true, uniqueness: {case_sensitive: true}
	validates :password, presence: true, length: {maximum: 20}
	has_secure_password

end
