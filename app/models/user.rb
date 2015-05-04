
class User < ActiveRecord::Base

	validates :email, :username, :presence => true
	validates :password, :presence => true
	validates :password, :confirmation => true
	validates :email, :username, :uniqueness => true
	validates :password, :length => { :minimum => 8 }
	validates :answer_for_password_question, :presence => true


	validates :privacy, inclusion: { in: [1,2] }
	
	has_many :memberships, :dependent => :destroy
	has_many :membershipForums, class_name: 'Forum', through: :memberships, source: :forum

  	has_many :friends, :through => :friendships 
	has_many :requested_friends, :through => :friendships, :source => :friend
	has_many :pending_friends, :through => :friendships, :source => :friend
	has_many :friendships, :dependent => :destroy
    has_many :blockers, :dependent => :destroy, foreign_key: :blocker_id ,:counter_cache => true
    has_many :bfriends , :through => :blockers , source: :friend
    has_many :report_users , :dependent => :destroy, foreign_key: :reporter_id
    has_many :rfriends , :through => :report_users , source: :friend



	has_many :admins, :dependent => :destroy
	has_many :adminForums, class_name: 'Forum', through: :admins, source: :forum

	has_many :ideas, :dependent => :destroy
	has_many :ideaForums, class_name: 'Forum', through: :ideas, source: :forum

	has_many :comments, :dependent => :destroy
	has_many :ideas, through: :comments

	#has_many :blocks, :dependent => :destroy

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
      		#user.save!
    	end
	end

end




