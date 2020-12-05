class CreateLeagueOfLegendsProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :league_of_legends_profiles, id: :uuid do |t|
      t.string :summoner_name
      t.integer :summoner_id
      t.string :region
      t.text :champions, array: true
      t.text :roles, array: true
      t.integer :profile_icon_id
      t.integer :summoner_level
      t.text :description
      t.datetime :riot_updated_at

      t.timestamps
    end
  end
end
