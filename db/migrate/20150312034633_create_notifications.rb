class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :info
      t.boolean :seen

      t.timestamps
    end
  end
end
