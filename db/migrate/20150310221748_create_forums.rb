class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.string :title
      t.string :description
      t.string :privacy

      t.timestamps
    end
  end
end
