class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.belongs_to :forum, index: true
      t.belongs_to :user, index: true
      t.boolean :accept

      t.timestamps
    end
  end
end
