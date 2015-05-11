class Reportcomment < ActiveRecord::Base
	
	belongs_to :comment, foreign_key: :comment_id

	validates :user_id, uniqueness: { scope: :comment_id }, presence: true
	validates :comment_id, presence: true

end
