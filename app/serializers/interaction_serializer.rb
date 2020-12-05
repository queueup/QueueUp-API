# frozen_string_literal: true

class InteractionSerializer < ActiveModel::Serializer
  attributes :id, :liked
  has_one :game_profile
  has_one :target
end
