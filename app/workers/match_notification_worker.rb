# frozen_string_literal: true

class MatchNotificationWorker
  include Sidekiq::Worker

  def perform(match_membership_id)
    match_membership = MatchMembership.find(match_membership_id)

    return if match_membership&.user&.devices&.empty?

    texts = NotificationText.new_match_membership
    notification = OneSignalApi.new(
      collapse_id:        'match:new',
      contents:           texts[:contents],
      data:               {
        gameProfileId: match_membership&.game_profile_id,
        matchId: match_membership&.match_id,
        verb: 'match:new'
      },
      headings:           texts[:headings],
      include_player_ids: match_membership&.user&.devices&.pluck(:player_id)
    )
    notification.create_notification
  end
end
