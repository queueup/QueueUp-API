class CreateLeagueOfLegendsMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :league_of_legends_matches, id: :uuid do |t|
      t.string :game_id
      t.string :platform_id
      t.belongs_to :league_of_legends_profile, foreign_key: true, type: :uuid
      t.datetime :started_at

      t.timestamps
    end
  end
end
