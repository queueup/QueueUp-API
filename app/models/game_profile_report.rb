# frozen_string_literal: true

class GameProfileReport < ApplicationRecord
  after_create :send_discord_notification

  enum reason: %i[spam bot offensive other]

  belongs_to :game_profile, optional: false
  belongs_to :target_profile, class_name: 'GameProfile', inverse_of: :received_game_profile_reports, optional: false

  validates :game_profile, uniqueness: { scope: :target_profile }
  validates :reason, presence: true

  private

  def send_discord_notification
    DiscordNotificationWorker.new.perform(
      ENV['DISCORD_REPORT_WEBHOOK_URL'],
      '',
      [{
        author:      {
          name:     target_profile.name,
          icon_url: target_profile.avatar_url
        },
        description: "**[#{reason}]** #{description}",
        footer:      {
          text:     game_profile.name,
          icon_url: game_profile.avatar_url
        },
        timestamp:   Time.zone.now.iso8601
      }]
    )
  end
end
