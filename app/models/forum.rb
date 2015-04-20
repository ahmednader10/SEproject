class Forum < ActiveRecord::Base
	validates :title, :presence => true
	has_many :memberships, :dependent => :destroy
	has_many :users, through: :memberships, :dependent => :destroy

	has_many :admins, :dependent => :destroy
	has_many :users, through: :admins, :dependent => :destroy

	validates :privacy, inclusion: { in: ["1", "2"] }
	



	has_many :ideas, :dependent => :destroy
	has_many :users, through: :ideas, :dependent => :destroy

end
