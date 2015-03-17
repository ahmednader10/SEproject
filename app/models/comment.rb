class Comment < ActiveRecord::Base
	# attr_accessible :text
	
	belongs_to :user
	belongs_to :idea

	validates  :text, :presence => true

end