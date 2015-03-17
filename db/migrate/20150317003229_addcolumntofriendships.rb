class Addcolumntofriendships < ActiveRecord::Migration
  def change
  	add_column :friendships , :accepted , :boolean
  	add_column :friendships , :rejected , :boolean
  	add_column :friendships , :requesting , :string 
  	add_column :friendships , :pending , :string

  end
end
