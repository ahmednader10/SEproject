class AddRequestsToFriendships < ActiveRecord::Migration
  def change
    add_column :friendships, :requests, :string
  end
end
