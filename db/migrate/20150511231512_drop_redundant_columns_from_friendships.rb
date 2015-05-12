class DropRedundantColumnsFromFriendships < ActiveRecord::Migration
  def change
  	remove_column :friendships, :user_name
  	remove_column :friendships, :friend_name
  	remove_column :friendships, :accepted
  	remove_column :friendships, :rejected
  	remove_column :friendships, :requester
  	remove_column :friendships, :requested
  	remove_column :friendships, :requests
  end
end
