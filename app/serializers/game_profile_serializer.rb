# frozen_string_literal: true

class GameProfileSerializer < ActiveModel::Serializer
  attributes :id,
             :resource_type,
             :scores

  belongs_to :resource
  belongs_to :user, serializer: LightUserSerializer
end
