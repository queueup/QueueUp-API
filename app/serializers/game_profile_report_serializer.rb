# frozen_string_literal: true

class GameProfileReportSerializer < ActiveModel::Serializer
  attributes :id, :reason, :description
  has_one :game_profile
  has_one :target_profile
end
