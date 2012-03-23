class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :score
      t.text :comment
      t.integer :suggestion_id
      t.integer :user_id

      t.timestamps
    end
  end
end
