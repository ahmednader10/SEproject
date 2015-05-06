class Friendship < ActiveRecord::Base



	belongs_to :user
	belongs_to :friend , :class_name => 'User'
	validates :user_id , :presence => true
	validates :friend_id , :presence => true

 
 has_many :bfriends , :through => :blockers , source: :user
    has_many :rfriends , :through => :report_users , source: :user

	
	
end