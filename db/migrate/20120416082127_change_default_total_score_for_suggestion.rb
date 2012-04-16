class ChangeDefaultTotalScoreForSuggestion < ActiveRecord::Migration
  def up
    change_column :suggestions, :total_votes, :integer, :default => 0
    change_column :suggestions, :total_score, :integer, :default => 0
    change_column :suggestions, :average_score, :float, :default => 0
  end

  def down
    change_column :suggestions, :total_votes, :integer
    change_column :suggestions, :total_score, :integer
    change_column :suggestions, :average_score, :float    
  end
end
