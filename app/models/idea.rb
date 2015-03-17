class Idea < ActiveRecord::Base

	
	belongs_to :user
	belongs_to :forum
	has_many :comments
	validates :title, :text, :presence => true
end

