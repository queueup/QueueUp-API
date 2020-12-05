# frozen_string_literal: true

class MatchSerializer < ActiveModel::Serializer
  attributes :id

  has_one :last_message

  has_many :match_memberships
  has_many :game_profiles
end
