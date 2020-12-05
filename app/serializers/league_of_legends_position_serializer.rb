# frozen_string_literal: true

class LeagueOfLegendsPositionSerializer < ActiveModel::Serializer
  attributes :id,
             :rank,
             :queue_type,
             :hot_streak,
             :wins,
             :veteran,
             :losses,
             :fresh_blood,
             :league_id,
             :player_or_team_name,
             :inactive,
             :player_or_team_id,
             :league_name,
             :tier,
             :league_points
end
