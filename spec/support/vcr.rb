# frozen_string_literal: true

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/cassettes'
  config.hook_into :webmock

  %w[
    DATABASE_URL
    DISCORD_TOKEN
    DISCORD_REPORT_WEBHOOK_URL
    DISCORD_METRICS_WEBHOOK_URL
    FACEBOOK_KEY
    FACEBOOK_SECRET
    FOREST_AUTH_SECRET
    FOREST_ENV_SECRET
    FORTNITE_API_KEY
    GOOGLE_KEY
    GOOGLE_SECRET
    ONESIGNAL_API_KEY
    ONESIGNAL_APP_ID
    PLAYSTV_APP_ID
    PLAYSTV_APP_KEY
    RIOT_API_KEY
    SENTRY_URL
    SIDEKIQ_WEB
    SMTP_ADDRESS
    SMTP_PORT
    SMTP_USER
    SMTP_PASSWORD
    SWAGGER_WEB
    TEST_DATABASE_URL
    WEBSITE_URL
  ].each do |key|
    config.filter_sensitive_data(key) do
      ENV[key]
    end
  end
end

# rubocop:disable Style/RegexpLiteral
RSpec.configure do |config|
  # Add VCR to all tests
  config.around do |example|
    vcr_tag = example.metadata[:vcr]

    if vcr_tag == false
      VCR.turned_off(&example)
    else
      options = vcr_tag.is_a?(Hash) ? vcr_tag : {}
      path_data = [example.metadata[:description]]
      parent = example.example_group
      while parent != RSpec::ExampleGroups
        path_data << parent.metadata[:description]
        parent = parent.parent
      end
      options[:record] = :new_episodes

      name = path_data.map { |str| str.underscore.delete('.').gsub(/[^\w\/]+/, '_').gsub(/\/$/, '') }.reverse.join('/')

      VCR.use_cassette(name, options, &example)
    end
  end
end
# rubocop:enable Style/RegexpLiteral
