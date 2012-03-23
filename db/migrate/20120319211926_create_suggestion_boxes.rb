class CreateSuggestionBoxes < ActiveRecord::Migration
  def change
    create_table :suggestion_boxes do |t|
      t.string :title
      t.text :description
      t.boolean :private
      t.boolean :votable
      t.boolean :anonymous_suggestions
      t.integer :organization_id
      t.integer :user_id

      t.timestamps
    end
  end
end
