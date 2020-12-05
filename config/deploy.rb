# frozen_string_literal: true

# Change these
set :repo_url,        'git@gitlab.com:queueupgg/QueueUp-API.git'
set :application,     'queueup-api'
set :user,            'queueup'
# set :puma_threads,    [4, 16]
# set :puma_workers,    0

set :pty,             false
set :use_sudo,        false
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/#{fetch(:application)}"
# set :passenger_restart_with_touch, true
# set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
# set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
# set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
# set :puma_access_log, "#{release_path}/log/puma.error.log"
# set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :sidekiq_log, "#{release_path}/log/sidekiq.log"
set :ssh_options, forward_agent: true, user: fetch(:user), keys: %w[~/.ssh/id_rsa]
# set :puma_preload_app, true
# set :puma_worker_timeout, nil
# set :puma_init_active_record, true

## Defaults:
# set :scm,           :git
# set :branch,        :master
# set :format,        :pretty
# set :log_level,     :debug
# set :keep_releases, 5

## Linked Files & Directories (Default None):
set :linked_files, %w[.env]
# set :linked_dirs,  %w[bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system]

# namespace :puma do
#   desc 'Create Directories for Puma Pids and Socket'
#   task :make_dirs do
#     on roles(:app) do
#       execute "mkdir #{shared_path}/tmp/sockets -p"
#       execute "mkdir #{shared_path}/tmp/pids -p"
#     end
#   end

#   before :start, :make_dirs
# end

SSHKit.config.command_map[:sidekiq] = 'bundle exec sidekiq'

namespace :deploy do
  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'passenger:start'
      invoke 'deploy'
    end
  end

  after :finishing, :cleanup
end

# rubocop:enable
