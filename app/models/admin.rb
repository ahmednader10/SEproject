class Admin < ActiveRecord::Base
	
	belongs_to :user, foreign_key: :user_id
	belongs_to :forum, foreign_key: :forum_id

	validates_uniqueness_of :user_id , scope: :forum_id

end
