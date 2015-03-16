class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :forumid
      t.integer :userid
      t.integer :ideaid
      t.string :text

      t.timestamps
    end
  end
end
