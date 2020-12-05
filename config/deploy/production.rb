# frozen_string_literal: true

server 'api.queueup.gg', port: 22, roles: %i[web app db], primary: true

set :stage, :production
set :branch, 'master'
# set :slackistrano,
#     klass: Slackistrano::CustomMessaging,
#     channel: '#api-deploy'
