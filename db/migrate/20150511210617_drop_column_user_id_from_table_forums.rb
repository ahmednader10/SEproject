class DropColumnUserIdFromTableForums < ActiveRecord::Migration
  def change
  	remove_column :forums, :user_id
  end
end
