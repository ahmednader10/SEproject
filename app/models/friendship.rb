class Friendship < ActiveRecord::Base

	validates_uniqueness_of :user_id, scope: :friend_id
	validates_uniqueness_of :friend_id, scope: :user_id
	validates :user_id , presence: true
	validates :friend_id , presence: true
	
	belongs_to :user
	belongs_to :friend , class_name: 'User'

	has_many :bfriends , through: :blockers , source: :user
	has_many :rfriends , through: :report_users , source: :user

	
	
end