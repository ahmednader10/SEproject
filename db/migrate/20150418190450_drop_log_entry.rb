class DropLogEntry < ActiveRecord::Migration
  def change
  	drop_table :log_entries
  end
end
