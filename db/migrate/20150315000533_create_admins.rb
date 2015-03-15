class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.belongs_to :forum, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
