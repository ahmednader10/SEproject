class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :text
      t.integer :forum_id
      t.integer :user_id

      t.timestamps
    end
  end
end
