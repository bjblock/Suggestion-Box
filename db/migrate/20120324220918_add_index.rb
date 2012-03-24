class AddIndex < ActiveRecord::Migration
  def up
    add_index :invitation_keys, :suggestion_box_id
    add_index :suggestion_boxes, :user_id
    add_index :suggestion_boxes, :organization_id
    add_index :suggestions, :suggestion_box_id
    add_index :suggestions, :user_id
    add_index :votes, :suggestion_id
    add_index :votes, :user_id
  end

  def down
    remove_index :invitation_keys, :suggestion_box_id
    remove_index :suggestion_boxes, :user_id
    remove_index :suggestion_boxes, :organization_id
    remove_index :suggestions, :suggestion_box_id
    remove_index :suggestions, :user_id
    remove_index :votes, :suggestion_id
    remove_index :votes, :user_id
  end
end
