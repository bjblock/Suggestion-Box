class AddKeyToInvitationKey < ActiveRecord::Migration
  def change
    add_column :invitation_keys, :key, :string

  end
end
