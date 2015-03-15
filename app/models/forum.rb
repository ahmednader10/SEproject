class Forum < ActiveRecord::Base
	validates :privacy, inclusion: { in: ["1", "2"] }
	belongs_to :user
	has_many :ideas
end
