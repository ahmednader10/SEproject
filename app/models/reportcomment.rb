class Reportcomment < ActiveRecord::Base
	validates :user_id, uniqueness: { scope: :comment_id }, presence: true
	validates :comment_id, presence: true
end
