class AddIsHiddenColumnToActions < ActiveRecord::Migration
  def change
  	add_column :actions, :isHidden, :boolean
  end
end
