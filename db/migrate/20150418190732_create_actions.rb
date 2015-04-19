class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.string :info

      t.timestamps
    end
  end
end
