# frozen_string_literal: true

class MatchMembershipSerializer < ActiveModel::Serializer
  attributes :id, :messages_read_at, :match_id
  has_one :game_profile
end
