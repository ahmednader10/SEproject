class Forum < ActiveRecord::Base
	validates :title, :presence => true
	has_many :memberships
	has_many :users, through: :memberships

	has_many :admins
	has_many :users, through: :admins

	validates :privacy, inclusion: { in: ["1", "2"] }
	belongs_to :user
	has_many :ideas
end
