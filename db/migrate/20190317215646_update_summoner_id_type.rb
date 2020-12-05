class UpdateSummonerIdType < ActiveRecord::Migration[5.1]
  def change
    change_column :league_of_legends_profiles, :summoner_id, :string
  end
end
