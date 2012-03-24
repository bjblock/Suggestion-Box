class CreateInvitationKeys < ActiveRecord::Migration
  def change
    create_table :invitation_keys do |t|
      t.integer :suggestion_box_id

      t.timestamps
    end
  end
end
