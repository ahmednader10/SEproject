class ChangeDefaultOfStatus < ActiveRecord::Migration
  def change
  	change_column_default :friendships, :status, nil
  end
end
