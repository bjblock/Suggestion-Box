class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.string :name
      t.text :description
      t.string :link
      t.boolean :anonymous
      t.integer :total_votes
      t.integer :total_score
      t.float :average_score
      t.integer :suggestion_box_id
      t.integer :user_id

      t.timestamps
    end
  end
end
