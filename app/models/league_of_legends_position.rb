# frozen_string_literal: true

class LeagueOfLegendsPosition < ApplicationRecord
  belongs_to :league_of_legends_profile

  def self.from_ranked_data(ranked_data)
    return [] if ranked_data.nil?

    ranked_data.map do |data|
      {
        rank:                         data['rank'],
        queue_type:                   data['queueType'],
        hot_streak:                   data['hotStreak'],
        wins:                         data['wins'],
        veteran:                      data['veteran'],
        losses:                       data['losses'],
        fresh_blood:                  data['freshBlood'],
        league_id:                    data['leagueId'],
        player_or_team_name:          data['playerOrTeamName'],
        inactive:                     data['inactive'],
        player_or_team_id:            data['playerOrTeamId'],
        league_name:                  data['leagueName'],
        tier:                         data['tier'],
        league_points:                data['leaguePoints']
      }
    end
  end
end
