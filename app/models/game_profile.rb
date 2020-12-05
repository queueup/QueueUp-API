# frozen_string_literal: true

class GameProfile < ApplicationRecord
  after_commit :force_resource_reload, on: :create

  belongs_to :user
  belongs_to :resource, polymorphic: true
  has_many :interactions, dependent: :destroy
  has_many :match_memberships, dependent: :destroy
  has_many :game_profile_scores, dependent: :destroy
  has_many :received_game_profile_scores,
           class_name:  'GameProfileScore',
           dependent:   :destroy,
           foreign_key: :target_game_profile_id,
           inverse_of:  :target_game_profile
  has_many :game_profile_reports, dependent: :destroy
  has_many :received_game_profile_reports,
           class_name:  'GameProfileReport',
           dependent:   :destroy,
           foreign_key: :target_profile_id,
           inverse_of:  :target_profile
  has_many :matches, through: :match_memberships
  has_many :messages, dependent: :destroy
  has_many :related_game_profiles, through: :match_memberships, source: :game_profile

  def self.eligible_for(game_profile)
    suggestions = where(resource_type: game_profile.resource_type)
    suggestions = suggestions.includes(:user, :resource)
    suggestions = suggestions.where.not(id: game_profile.id)
    suggestions = suggestions.where.not(user: game_profile.user_id)
    suggestions = suggestions.where.not(id: Interaction.where(game_profile: game_profile).pluck(:target_id))

    game_profile.update(cleared_suggestions_at: Time.zone.now) if suggestions.empty? && game_profile.cleared_suggestions_at.nil?

    suggestions.order(connected_at: :desc)
  end

  protected

  def force_resource_reload
    resource.force_update
  end
end
