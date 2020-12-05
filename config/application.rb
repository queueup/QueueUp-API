# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
# require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Queueup
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.generators do |g|
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
      g.orm :active_record, primary_key_type: :uuid
      g.test_framework :rspec,
                       controller_specs: false,
                       fixtures:         true,
                       helper_specs:     false,
                       request_specs:    true,
                       routing_specs:    true,
                       view_specs:       false
    end

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'localhost:3000',
                'app.forestadmin.com',
                /\A.*\.queueup.gg\z/
        resource '*',
                 expose:  %w[access-token client content-disposition expiry token-type uid],
                 headers: :any,
                 methods: :any,
                 credentials: true
      end
    end

    config.action_mailer.default_url_options = { host: ENV['WEBSITE_URL'] }
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address:              ENV['SMTP_ADDRESS'],
      port:                 ENV['SMTP_PORT'],
      user_name:            ENV['SMTP_USER'],
      password:             ENV['SMTP_PASSWORD'],
      enable_starttls_auto: false,
      ssl:                   true,
      tls:                   true
    }

    if Rails.env.production?
      Raven.configure do |config|
        config.dsn = ENV['SENTRY_URL']
      end
    end
  end
end
