class RemoveCnFromBlockers < ActiveRecord::Migration
  def change
  	remove_column :blockers, :blocked_count, :integer
  end
end
