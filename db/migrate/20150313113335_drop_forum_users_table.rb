class DropForumUsersTable < ActiveRecord::Migration
  def change
  	drop_table :forum_users
  end
end
