
class User < ActiveRecord::Base

	validates :email, :username, :presence => true
	validates :password, :presence => true
	validates :password, :confirmation => true
	validates :email, :username, :uniqueness => true
	validates :password, :length => { :minimum => 8 }

	has_many :memberships, :dependent => :delete_all
	has_many :forums, through: :memberships, :dependent => :delete_all

  	has_many :friends, :through => :friendships, :dependent => :delete_all 
	has_many :requested_friends, :through => :friendships, :source => :friend, :dependent => :delete_all
	has_many :pending_friends, :through => :friendships, :source => :friend, :dependent => :delete_all
	has_many :friendships, :dependent => :delete_all

	has_many :admins, :dependent => :delete_all
	has_many :forums, through: :admins, :dependent => :delete_all

	has_many :ideas, :dependent => :delete_all
	has_many :forums, through: :ideas, :dependent => :delete_all

	has_many :comments, :dependent => :delete_all
	has_many :ideas, through: :comments, :dependent => :delete_all


	#Authenticate method used in Session controller
	def authenticate (password)
		if password == self.password
			 true
		else
			false
		end
	end

	#Used in Session controller 
	#Facebook API
	def self.omniauth(auth)
    	where(auth.slice(:provider, :uid).permit!).first_or_create.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      #user.image = auth.info.image
      #user.token = auth.credentials.token
      #user.expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    	end
	end

end




