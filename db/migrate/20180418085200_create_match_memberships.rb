class CreateMatchMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :match_memberships, id: :uuid do |t|
      t.belongs_to :game_profile, foreign_key: true, type: :uuid
      t.belongs_to :match, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
