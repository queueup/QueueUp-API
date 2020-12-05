# frozen_string_literal: true

class ScoreMatchNotificationWorker
  include Sidekiq::Worker

  def perform(match_id)
    match = Match.find(match_id)

    return if match&.game_profiles&.length != 2

    match&.game_profiles&.to_a&.permutation&.to_a&.each do |game_profiles|
      next if GameProfileScore.exists?(game_profile: game_profiles&.first, target_game_profile: game_profiles&.last)

      texts = NotificationText.new_score_match(game_profiles.last)
      notification = OneSignalApi.new(
        collapse_id:        'score_match:new',
        contents:           texts[:contents],
        data:               {
          gameProfileIds: game_profiles&.pluck(:id),
          matchId:        match&.id,
          verb:           'score_match:new'
        },
        headings:           texts[:headings],
        include_player_ids: game_profiles&.first&.user&.devices&.pluck(:player_id)
      )
      notification.create_notification
    end
  end
end
