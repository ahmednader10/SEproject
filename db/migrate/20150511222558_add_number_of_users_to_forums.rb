class AddNumberOfUsersToForums < ActiveRecord::Migration
  def change
  	add_column :forums, :numberOfUsers, :integer
  end
end
