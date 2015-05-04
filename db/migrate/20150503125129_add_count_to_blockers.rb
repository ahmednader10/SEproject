class AddCountToBlockers < ActiveRecord::Migration
  def change
  	add_column :blockers , :blocked_count , :int , column_options: {null: false} , default: 0 
  	Blocker.each {|b| Blocker.reset_counters b , :blocked } 
  	
  end
end
