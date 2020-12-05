# frozen_string_literal: true

class GameProfileScoreSerializer < ActiveModel::Serializer
  attributes :id
  has_one :score
end
