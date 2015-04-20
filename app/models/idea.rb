class Idea < ActiveRecord::Base

	
	belongs_to :user
	belongs_to :forum

	has_many :comments, :dependent => :delete_all
	validates :title, :text, :user, :forum, :presence => true

end

