class AddPrivacyToUsers < ActiveRecord::Migration
  def change
  	add_column :users , :privacy , :int
  end
end
