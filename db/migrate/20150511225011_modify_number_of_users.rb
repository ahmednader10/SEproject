class ModifyNumberOfUsers < ActiveRecord::Migration
  def change
  	remove_column :forums, :numberOfUsers
  	add_column :forums, :user_count, :integer, default: 0
  end
end
