class AddLikeCountToIdeas < ActiveRecord::Migration
  def change
  	add_column :ideas, :like_count, :integer, default: 0
  end
end
