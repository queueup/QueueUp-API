# frozen_string_literal: true

class MessageNotificationWorker
  include Sidekiq::Worker

  def perform(message_id)
    message = Message.find(message_id)

    return if message.nil? || message&.devices&.empty?

    notified_devices = message.devices.pluck(:player_id) - message&.user&.devices&.pluck(:player_id)

    return if notified_devices&.empty?

    texts = NotificationText.new_message(message)
    notification = OneSignalApi.new(
      collapse_id:        'message:new',
      contents:           texts[:contents],
      data:               {
        gameProfileIds: message&.game_profile_ids,
        matchId:        message&.match&.id,
        messageId:      message&.id,
        verb:           'message:new'
      },
      headings:           texts[:headings],
      include_player_ids: notified_devices
    )
    notification.create_notification
  end
end
