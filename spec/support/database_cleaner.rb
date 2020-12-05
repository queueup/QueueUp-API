# frozen_string_literal: true

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before do
    DatabaseCleaner.strategy = :truncation, { except: %w[scores] }
  end

  # config.before(:each, type: :feature) do
  #   # :rack_test driver's Rack app under test shares database connection
  #   # with the specs, so we can use transaction strategy for speed.
  #   driver_shares_db_connection_with_specs = Capybara.current_driver == :rack_test

  #   DatabaseCleaner.strategy = :transaction
  # end

  config.before do
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end
end
