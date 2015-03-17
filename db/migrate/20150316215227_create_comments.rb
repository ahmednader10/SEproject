class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.integer :idea_id
    	t.integer :user_id
    	t.text :text

      t.timestamps
    end
  end
end
