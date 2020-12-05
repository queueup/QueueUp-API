# frozen_string_literal: true

class LightUserSerializer < ActiveModel::Serializer
  attributes :locales, :badges, :favorite_badge
end
