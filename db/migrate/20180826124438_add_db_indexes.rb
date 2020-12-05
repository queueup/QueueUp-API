class AddDbIndexes < ActiveRecord::Migration[5.1]
  def change
    add_index :game_profiles, :resource_id
    add_index :game_profiles, :resource_type
    add_index :league_of_legends_profiles, :summoner_name
    add_index :league_of_legends_profiles, :region
  end
end
