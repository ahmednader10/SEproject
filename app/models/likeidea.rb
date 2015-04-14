class Likeidea < ActiveRecord::Base
	validates :user_id, uniqueness: { scope: :idea_id }
end
