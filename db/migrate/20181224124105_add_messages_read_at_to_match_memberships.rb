class AddMessagesReadAtToMatchMemberships < ActiveRecord::Migration[5.1]
  def up
    add_column :match_memberships, :messages_read_at, :datetime

    MatchMembership.all.update(messages_read_at: Time.zone.now)
  end

  def down
    drop_column :match_memberships, :messages_read_at
  end
end
