class Admin < ActiveRecord::Base
	belongs_to :user
	belongs_to :forum

	validates_uniqueness_of :user_id , scope: :forum_id

<<<<<<< HEAD
	#attr_accessible :user
=======

>>>>>>> 2a2a7bd6ce768d0cd89cb20e7abbc41e9877a2c5
end
