
class User < ActiveRecord::Base

	validates :email, :username, :presence => true
	validates :password, :presence => true
	validates :password, :confirmation => true
	validates :email, :username, :uniqueness => true
	validates :password, :length => { :minimum => 8 }

	attr_accessible :email, :password, :password_confirmation, :username, :gender, :full_name, :password_question, :answer_for_password_question


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

