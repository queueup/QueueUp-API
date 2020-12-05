# frozen_string_literal: true

class DiscordWebhook
  def initialize(webhook_url = '')
    @webhook_url = webhook_url
  end

  def send(body)
    HTTParty.post(@webhook_url,
                  body: body.to_json,
                  headers: {
                    'Content-Type': 'application/json'
                  })
  end
end
