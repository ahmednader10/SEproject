class Action < ActiveRecord::Base
	belongs_to :user, foreign_key: :user_email, primary_key: :email
	validates :user_email, presence: true
end
