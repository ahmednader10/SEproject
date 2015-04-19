class RemoveRequestingFromFriendships < ActiveRecord::Migration
  def change
     remove_column :friendships, :pending, :string

  end
end
