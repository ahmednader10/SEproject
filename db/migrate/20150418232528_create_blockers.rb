class CreateBlockers < ActiveRecord::Migration
  def change
    create_table :blockers do |t|
      t.integer :blocker_id
      t.integer :blocked_id
      t.string :blocker
      t.string :blocked

      t.timestamps
    end
  end
end
