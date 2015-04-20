class Idea < ActiveRecord::Base

	
	belongs_to :user
	belongs_to :forum
	has_many :comments, :dependent => :destroy
	validates :title, :text, :presence => true

end

