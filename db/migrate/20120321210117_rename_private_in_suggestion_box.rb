class RenamePrivateInSuggestionBox < ActiveRecord::Migration
  def up
    rename_column :suggestion_boxes, :private, :by_invite_only
  end

  def down
    rename_column :suggestion_boxes, :by_invite_only, :private
  end
end
