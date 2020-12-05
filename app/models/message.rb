# frozen_string_literal: true

# Message status is stored in the MatchMembership, as a date of last read
# Last read is updated in MessagesController, before render

class Message < ApplicationRecord
  after_create :create_notifications

  belongs_to :game_profile, optional: false
  has_one :user, through: :game_profile
  belongs_to :match, optional: false
  has_many :match_memberships, through: :match
  has_many :game_profiles, through: :match
  has_many :users, through: :game_profiles
  has_many :devices, through: :users

  validates :content, presence: true, allow_blank: false

  private

  def create_notifications
    MatchNotificationWorker.perform_async(id)
  end
end
