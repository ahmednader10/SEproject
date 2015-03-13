class Forum < ActiveRecord::Base
	has_many :memberships
	has_many :users, through: :memberships
	validates :privacy, inclusion: { in: ["1", "2"] }
end
