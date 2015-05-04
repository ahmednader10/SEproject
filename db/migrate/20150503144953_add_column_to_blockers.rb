class AddColumnToBlockers < ActiveRecord::Migration
  def change
  end

  def self.up

add_column :blockers , :blocked_count , :integer , :default => 0
Blocker.reset_column_information
Blocker.find(:all).each do |b|

	Blocker.update_counters b.blocked_id, :tasks_count => b.blockers.length
end
end 

def self.down 
	remove_column :blockers  , :blocked_count



  end 
end
