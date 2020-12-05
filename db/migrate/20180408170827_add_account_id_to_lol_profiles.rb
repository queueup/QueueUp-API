class AddAccountIdToLolProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :league_of_legends_profiles, :account_id, :string, index: true
    LeagueOfLegendsProfile.all.each do |profile|
      profile.send(:set_api_summoner)
      profile.save
    end
  end
end
