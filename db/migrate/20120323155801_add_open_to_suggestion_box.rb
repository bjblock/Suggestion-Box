class AddOpenToSuggestionBox < ActiveRecord::Migration
  def change
    add_column :suggestion_boxes, :open, :boolean, :default => true

  end
end
