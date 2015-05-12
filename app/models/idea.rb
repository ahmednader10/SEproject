class Idea < ActiveRecord::Base
	
	belongs_to :user, foreign_key: :user_id
	belongs_to :forum, foreign_key: :forum_id

	has_many :comments, dependent: :delete_all
	has_many :users, through: :comments
	
	has_many :likeideas, dependent: :delete_all
	has_many :users, through: :likeideas
	
	validates :title, :text, :user, :forum, presence: true

end