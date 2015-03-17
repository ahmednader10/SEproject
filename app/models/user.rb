
class User < ActiveRecord::Base

	validates :email, :username, :presence => true
	validates :password, :presence => true
	validates :password, :confirmation => true
	validates :email, :username, :uniqueness => true
	validates :password, :length => { :minimum => 8 }

	# Protected attributes gem
	#attr_accessible :email, :password, :password_confirmation, :username, :gender, :full_name, :password_question, :answer_for_password_question

	has_many :memberships
	has_many :forums, through: :memberships

	has_many :admins
	has_many :forums, through: :admins

	has_many :friendships
	has_many :friends, through: :friendships

	has_many :ideas
	has_many :forums, through: :ideas

	has_many :comments
	has_many :ideas, through: :comments

	#Authenticate method used in Session controller
	def authenticate (password)
		if password == self.password
			 true
		else
			false
		end
	end

	#Used in Session controller 
	#Facebook and Twitter API
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

