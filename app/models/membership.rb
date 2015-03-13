class Membership < ActiveRecord::Base
	belongs_to :user
	belongs_to :forum

	validates_uniqueness_of :user_id , scope: :forum_id


end
