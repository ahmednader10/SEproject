class AddHiddenToActions < ActiveRecord::Migration
  def change
  	add_column :actions, :hidden, :boolean, default: false
  end
end
