# frozen_string_literal: true

require 'dotenv'
Dotenv.load

# Load DSL and Setup Up Stages
require 'capistrano/setup'
require 'capistrano/deploy'

require 'capistrano/bundler'
require 'capistrano/rails/migrations'
require 'capistrano/rvm'
require 'capistrano/passenger'
# require 'capistrano/puma'
require 'capistrano/sidekiq'
require 'capistrano/scm/git'

require 'slackistrano/capistrano'
require 'whenever/capistrano'

require_relative 'lib/slackistrano'

# install_plugin Capistrano::Puma
install_plugin Capistrano::SCM::Git

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
