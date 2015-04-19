class CreateReportUsers < ActiveRecord::Migration
  def change
    create_table :report_users do |t|
    	t.integer :reporter_id
      t.integer :reported_id
      t.string :reporter
      t.string :reported

      t.timestamps
    end
  end
end
