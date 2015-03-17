class Idea < ActiveRecord::Base
	#attr_accessible :title, :text
	
	belongs_to :user
	belongs_to :forum
	has_many :comments
	validates :title, :text, :presence => true
end

