# frozen_string_literal: true

Devise.setup do |config|
  config.secret_key = ENV['SECRET_KEY_BASE']
  config.mailer_sender = '"QueueUp" <no_reply@queueup.gg>'
end
