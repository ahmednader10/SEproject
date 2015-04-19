class AddColsToFriendships < ActiveRecord::Migration
  def change
    add_column :friendships, :requester, :string
    add_column :friendships, :requested, :string
  end
end
