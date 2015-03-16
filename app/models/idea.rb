class Idea < ActiveRecord::Base
	belongs_to :user
	belongs_to :forum
	validates :title, :text, :presence => true

	attr_accessible :title , :text 
end
