class RemoveReqFromFriendships < ActiveRecord::Migration
  def change
    remove_column :friendships, :requesting, :string
  end
end
