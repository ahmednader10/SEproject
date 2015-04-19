class DropIsHiddenFromActions < ActiveRecord::Migration
  def change
  	remove_column :actions, :isHidden
  end
end
