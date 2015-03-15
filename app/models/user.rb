class User < ActiveRecord::Base

	validates :email, :username, :presence => true
	validates :password, :presence => true
	validates :password, :confirmation => true
	validates :email, :username, :uniqueness => true
	validates :password, :length => { :minimum => 8 }

	has_many :ideas
	has_many :forums


	#Authenticate method used in Session controller
	def authenticate (password)
		if password == self.password
			 true
		else
			false
		end
	end

end
