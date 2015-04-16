class ChangeColumnPrivacy < ActiveRecord::Migration
  def change
  	change_column :users , :privacy, :int, default: 1
  end
end
