# frozen_string_literal: true

Sidekiq.configure_client do |config|
  config.redis = {
    namespace: 'QueueUp',
    url:       ENV['REDIS_URL']
  }
end

Sidekiq.configure_server do |config|
  config.redis = {
    namespace: 'QueueUp',
    url:       ENV['REDIS_URL']
  }
end
