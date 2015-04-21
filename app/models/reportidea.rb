class Reportidea < ActiveRecord::Base
	validates :user_id, uniqueness: { scope: :idea_id }, presence: true
	validates :idea_id, presence: true
end
