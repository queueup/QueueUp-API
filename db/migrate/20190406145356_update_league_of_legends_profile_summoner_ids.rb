class UpdateLeagueOfLegendsProfileSummonerIds < ActiveRecord::Migration[5.1]
  def up
    LeagueOfLegendsProfile.all.each do |lp|
      lp.send(:set_api_summoner)
      lp.save
    end
  end
end
