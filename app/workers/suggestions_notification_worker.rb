# frozen_string_literal: true

class SuggestionsNotificationWorker
  include Sidekiq::Worker

  def perform(game_profile_id)
    game_profile = GameProfile.find(game_profile_id)

    return if game_profile&.user&.devices&.empty?

    texts = NotificationText.new_suggestions(game_profile)
    notification = OneSignalApi.new(
      collapse_id:        'suggestions:new',
      contents:           texts[:contents],
      data:               {
        gameProfileId: game_profile_id,
        verb: 'suggestions:new'
      },
      headings:           texts[:headings],
      include_player_ids: game_profile&.user&.devices&.pluck(:player_id)
    )
    notification.create_notification
  end
end
