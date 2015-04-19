class CreateLogEntries < ActiveRecord::Migration
  def change
    create_table :log_entries do |t|

      t.timestamps
    end
  end
end
