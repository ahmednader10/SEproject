class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :username
      t.string :gender
      t.string :full_name
      t.string :password_question
      t.string :answer_for_password_question
      
      t.timestamps
    end
  end
end
