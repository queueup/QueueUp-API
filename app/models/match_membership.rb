# frozen_string_literal: true

class MatchMembership < ApplicationRecord
  after_create :create_notification
  belongs_to :game_profile, optional: false
  belongs_to :match, optional: false, dependent: :destroy
  has_one :user, through: :game_profile

  validates :match, uniqueness: { scope: :game_profile }

  private

  def create_notification
    MatchNotificationWorker.perform_async(id)
  end
end
