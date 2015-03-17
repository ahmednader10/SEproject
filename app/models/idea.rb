class Idea < ActiveRecord::Base

	
	belongs_to :user
	belongs_to :forum
	has_many :comments
	validates :title, :text, :presence => true
<<<<<<< HEAD

	#attr_accessible :title , :text 
=======
>>>>>>> 2a2a7bd6ce768d0cd89cb20e7abbc41e9877a2c5
end

