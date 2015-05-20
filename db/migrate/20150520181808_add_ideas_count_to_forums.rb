class AddIdeasCountToForums < ActiveRecord::Migration
  def change
  	add_column :forums, :idea_count, :integer, default: 0
  end
end
