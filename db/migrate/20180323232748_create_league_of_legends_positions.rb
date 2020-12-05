class CreateLeagueOfLegendsPositions < ActiveRecord::Migration[5.1]
  def change
    create_table :league_of_legends_positions, id: :uuid do |t|
      t.belongs_to :league_of_legends_profile,
        foreign_key: true,
        type: :uuid,
        index: {name: 'index_lol_positions_on_lol_profile_id'}
      t.string :rank
      t.string :queue_type
      t.boolean :hot_streak
      t.integer :wins
      t.boolean :veteran
      t.integer :losses
      t.boolean :fresh_blood
      t.string :league_id
      t.string :player_or_team_name
      t.boolean :inactive
      t.string :player_or_team_id
      t.string :league_name
      t.string :tier
      t.integer :league_points

      t.timestamps
    end
  end
end
