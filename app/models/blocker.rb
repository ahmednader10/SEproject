class Blocker < ActiveRecord::Base
	belongs_to :user, foreign_key: :blocker_id , :counter_cache => true
	belongs_to :friend , :class_name => 'User', foreign_key: :blocked_id , :counter_cache => true
	
end
