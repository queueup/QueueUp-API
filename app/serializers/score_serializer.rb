# frozen_string_literal: true

class ScoreSerializer < ActiveModel::Serializer
  attributes :id, :key, :positive
end
