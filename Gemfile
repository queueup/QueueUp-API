# frozen_string_literal: true

ruby '2.5.1'
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'dotenv-rails'

gem 'pg', '~> 0.18'
gem 'puma', '~> 3.10'
gem 'rails', '~> 5.1.5'

gem 'active_model_serializers', '~> 0.10.6'
gem 'cancancan', '~> 2.0'
gem 'devise_token_auth', github: 'queueup/devise_token_auth', branch: 'forgot_pass_with_reset_password_token'
gem 'forest_liana'
gem 'httparty', '~> 0.17.3'
gem 'koala'
gem 'mailjet'
gem 'merit'
gem 'rack-cors'
gem 'redis-namespace'
gem 'rswag-api'
gem 'rswag-ui'
gem 'sentry-raven'
gem 'sidekiq'
gem 'sqreen'
gem 'whenever', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'codecov', require: false
  gem 'database_cleaner', '~> 1.6', '>= 1.6.2'
  gem 'factory_bot_rails', '~> 4.0'
  gem 'faker'
  gem 'rspec-rails', '~> 3.7', '>= 3.7.1'
  gem 'rspec-sidekiq', require: false
  gem 'rswag-specs'
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
  gem 'simplecov'
  gem 'simplecov-console'
  gem 'sinatra'
  gem 'vcr'
  gem 'webmock'
end

group :development do
  gem 'capistrano',         require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-passenger', require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-sidekiq', require: false
  gem 'capistrano3-puma',   require: false
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'slackistrano'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
