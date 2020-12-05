# frozen_string_literal: true

class ScoreNotificationWorker
  include Sidekiq::Worker

  def perform(gp_score_id)
    gps = GameProfileScore.find(gp_score_id)

    return if gps&.target_game_profile&.user&.devices&.empty?

    texts = NotificationText.new_score
    notification = OneSignalApi.new(
      collapse_id:        'score:new',
      contents:           texts[:contents],
      data:               {
        gameProfileId: gps&.target_game_profile_id,
        verb: 'score:new'
      },
      headings:           texts[:headings],
      include_player_ids: gps&.target_game_profile&.user&.devices&.pluck(:player_id)
    )
    notification.create_notification
  end
end
