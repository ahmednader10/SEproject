class Forum < ActiveRecord::Base
	validates :title, :presence => true
	has_many :memberships, :dependent => :delete_all
	has_many :users, through: :memberships, :dependent => :delete_all

	has_many :admins, :dependent => :delete_all
	has_many :users, through: :admins, :dependent => :delete_all

	validates :privacy, inclusion: { in: ["1", "2"] }
	
	has_many :ideas, :dependent => :delete_all
	has_many :users, through: :ideas, :dependent => :delete_all
end
