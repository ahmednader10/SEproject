class AddUserEmailToActionsTable < ActiveRecord::Migration
  def change
  	add_column :actions, :user_email, :string
  end
end
