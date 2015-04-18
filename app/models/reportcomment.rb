class Reportcomment < ActiveRecord::Base
	validates :user_id, uniqueness: { scope: :comment_id }
end
