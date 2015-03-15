class User < ActiveRecord::Base
	has_many :memberships
	has_many :forums, through: :memberships

	has_many :admins
	has_many :forums, through: :admins

	validates :email, :username, :presence => true
	validates :password, :presence => true
	validates :password, :confirmation => true
	validates :email, :username, :uniqueness => true
	validates :password, :length => { :minimum => 8 }
	has_many :friendships
  has_many :friends, :through => :friendships

	has_many :ideas
	has_many :forums, through: :ideas


	#Authenticate method used in Session controller
	def authenticate (password)
		if password == self.password
			 true
		else
			false
		end
	end

end
