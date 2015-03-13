class Membership < ActiveRecord::Base
	belongs_to :user
	belongs_to :forum

	def self.join!(forum)
    membership = Membership.find(:first, :conditions => { :forum_id => forum.id } )
    mem.update_attribute(:accept, true)
  end
end
