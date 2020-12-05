# frozen_string_literal: true

class DiscordNotificationWorker
  include Sidekiq::Worker

  def perform(webhook_url, message = '', embeds = [])
    discord = DiscordWebhook.new(webhook_url)
    discord.send(content: message, embeds: embeds)
  end
end
