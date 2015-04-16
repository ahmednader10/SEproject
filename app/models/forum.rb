class Forum < ActiveRecord::Base
	validates :title, :presence => true
	has_many :memberships, :dependent => :delete_all
	has_many :users, through: :memberships, :dependent => :delete_all

	has_many :admins, :dependent => :delete_all
	has_many :users, through: :admins, :dependent => :delete_all

	validates :privacy, inclusion: { in: ["1", "2"] }
	
<<<<<<< HEAD
	has_many :ideas
	has_many :users, through: :ideas


=======
	has_many :ideas, :dependent => :delete_all
	has_many :users, through: :ideas, :dependent => :delete_all
>>>>>>> 637c03e3ebd9e2a567686a37062c9b6279fa4dad
end
