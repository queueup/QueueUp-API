# frozen_string_literal: true

server 'api-staging.queueup.gg', port: 22, roles: %i[web app db], primary: true

set :stage, :staging
set :branch, 'develop'
# set :slackistrano,
#     klass: Slackistrano::CustomMessaging,
#     channel: '#api-deploy',
#     webhook: ''
