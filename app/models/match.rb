# frozen_string_literal: true

class Match < ApplicationRecord
  default_scope { where(canceled_at: nil) }

  after_create :plan_notification

  has_many :messages, dependent: :destroy
  has_many :match_memberships, dependent: :destroy
  has_many :game_profiles, through: :match_memberships
  has_many :users, through: :game_profiles
  has_one :last_message, -> { order(created_at: :desc) }, class_name: 'Message', inverse_of: :match

  validate :memberships_validation

  def self.from_game_profiles(game_profile_ids)
    match_ids = game_profile_ids.map { |id| GameProfile.find(id).match_ids }
    match_ids = match_ids.reduce(Match.all.pluck(:id)) do |a, b|
      a & b
    end
    match_ids.empty? ? nil : Match.find(match_ids.first)
  end

  private

  def memberships_validation
    game_profiles.each do |gp|
      errors.add(:match_memberships, 'uniq') if gp.related_game_profiles.include?(game_profiles - [gp])
    end
  end

  def plan_notification
    ScoreMatchNotificationWorker.perform_in(2.days, id)
  end
end
