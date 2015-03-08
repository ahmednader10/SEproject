class User < ActiveRecord::Base

	validates :email, :username, :presence => true
	validates :password, :presence => true
	validates :password, :confirmation => true
	validates :email, :username, :uniqueness => true
	validates :password, :length => { :minimum => 8 }

end
