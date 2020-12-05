# frozen_string_literal: true

require 'devise'

RSpec.configure do |config|
  # For Devise >= 4.1.0
  config.include Devise::Test::ControllerHelpers, type: :controller
end
