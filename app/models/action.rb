class Action < ActiveRecord::Base
	belongs_to :user
	validates :user_email, presence: true
end
