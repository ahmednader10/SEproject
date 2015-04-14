class CreateReportideas < ActiveRecord::Migration
  def change
    create_table :reportideas do |t|
      t.integer :user_id
      t.integer :idea_id

      t.timestamps
    end
  end
end
