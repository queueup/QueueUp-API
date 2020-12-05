# frozen_string_literal: true

require 'codecov'
require 'simplecov'
require 'simplecov-console'

SimpleCov.formatter = ENV['CI'] == 'true' ? SimpleCov::Formatter::Codecov : SimpleCov::Formatter::Console

SimpleCov.start
