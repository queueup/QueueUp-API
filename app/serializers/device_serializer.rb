# frozen_string_literal: true

class DeviceSerializer < ActiveModel::Serializer
  attributes :id, :player_id
  has_one :user
end
