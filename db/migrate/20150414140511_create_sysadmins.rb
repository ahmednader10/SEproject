class CreateSysadmins < ActiveRecord::Migration
  def change
    create_table :sysadmins do |t|
      t.string :username
      t.string :password
      t.timestamps
    end
  end
end
