# frozen_string_literal: true

class MessageSerializer < ActiveModel::Serializer
  attributes :id, :content, :match_id, :created_at
  belongs_to :game_profile
  has_many :match_memberships
end
