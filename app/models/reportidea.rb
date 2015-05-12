class Reportidea < ActiveRecord::Base

	belongs_to :idea, foreing_key: :idea_id

	validates :user_id, uniqueness: { scope: :idea_id }, presence: true
	validates :idea_id, presence: true

end
