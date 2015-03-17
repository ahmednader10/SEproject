class Forum < ActiveRecord::Base
	validates :title, :presence => true
	has_many :memberships
	has_many :users, through: :memberships

	has_many :admins
	has_many :users, through: :admins

	validates :privacy, inclusion: { in: ["1", "2"] }
	
	has_many :ideas
	has_many :users, through: :ideas


<<<<<<< HEAD
	#attr_accessible :title, :description, :privacy
=======

>>>>>>> 2a2a7bd6ce768d0cd89cb20e7abbc41e9877a2c5
end
