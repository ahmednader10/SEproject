class Comment < ActiveRecord::Base
	
	belongs_to :user, foreign_key: :user_id
	belongs_to :idea, foreign_key: :idea_id

	validates  :text, :user, :idea, presence: true

end