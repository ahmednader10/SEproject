class ModifySeenColumnInNotifications < ActiveRecord::Migration
  def change
  	remove_column :notifications, :seen
  	add_column :notifications, :seen, :boolean, default: false
  end
end
