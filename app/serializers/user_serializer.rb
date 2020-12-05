# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id, :locales, :badges, :favorite_badge, :facebook_id, :google_id

  has_many :game_profiles
end
