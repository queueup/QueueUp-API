# frozen_string_literal: true

class LeagueOfLegendsProfileSerializer < ActiveModel::Serializer
  attributes :id,
             :summoner_name,
             :region,
             :champions,
             :roles,
             :profile_icon_id,
             :profile_icon_url,
             :summoner_level,
             :description,
             :riot_updated_at,
             :game_profile_id

  has_many :league_of_legends_positions, key: :positions

  def game_profile_id
    object.game_profile&.id
  end
end
