class Forum < ActiveRecord::Base
	
	validates :title, presence: true
	validates :category, presence: true
	validates_uniqueness_of :title, scope: :category

	has_many :memberships, dependent: :delete_all
	has_many :users, through: :memberships

	has_many :admins, dependent: :delete_all
	has_many :users, through: :admins

	validates :privacy, inclusion: { in: ["1", "2"] }
	
	has_many :ideas, dependent: :delete_all
	has_many :users, through: :ideas

end