class User < ActiveRecord::Base
	has_many :memberships
	has_many :forums, through: :memberships 

	validates :email, :username, :presence => true
	validates :password, :presence => true
	validates :password, :confirmation => true
	validates :email, :username, :uniqueness => true
	validates :password, :length => { :minimum => 8 }

end
