class DropUserIdFromActionsTable < ActiveRecord::Migration
  def change
  	remove_column :actions, :user_id
  end
end
