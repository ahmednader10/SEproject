class Forum < ActiveRecord::Base
	validates :title, :presence => true
	validates :privacy, inclusion: { in: ["1", "2"] }
end
