# frozen_string_literal: true

class FortniteProfileSerializer < ActiveModel::Serializer
  attributes :id,
             :handle,
             :platform,
             :description,
             :scout_updated_at,
             :game_profile_id,
             :platform,
             :picture_url,
             :duo,
             :squad,
             :fun,
             :try_hard,
             :kills_solo,
             :kills_duo,
             :kills_squad,
             :kd_solo,
             :kd_duo,
             :kd_squad,
             :played_solo,
             :played_duo,
             :played_squad

  def game_profile_id
    object.game_profile&.id
  end
end
