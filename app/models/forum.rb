class Forum < ActiveRecord::Base
	validates :privacy, inclusion: { in: ["1", "2"] }
end
