# frozen_string_literal: true

if defined?(Slackistrano::Messaging)
  module Slackistrano
    class CustomMessaging < Messaging::Base
      # Send failed message to #ops. Send all other messages to default channels.
      # The #ops channel must exist prior.
      def channels_for(action)
        super
      end

      # Suppress updating message.
      def payload_for_updating
        nil
      end

      # Suppress reverting message.
      def payload_for_reverting
        nil
      end

      # Fancy updated message.
      # See https://api.slack.com/docs/message-attachments
      def payload_for_updated
        {
          attachments: [{
            author_name: deployer,
            color: 'good',
            fields: [{
              title: last_commit,
              value: '_Deployment succeeded !_',
              short: true
            }, {
              title: 'Environment',
              value: stage,
              short: true
            }, {
              title: 'Branch',
              value: branch,
              short: true
            }, {
              title: 'Time',
              value: elapsed_time,
              short: true
            }],
            fallback: super[:text],
            ts: Time.now.to_i
          }]
        }
      end

      # Default reverted message.  Alternatively simply do not redefine this
      # method.
      def payload_for_reverted
        nil
      end

      # Slightly tweaked failed message.
      # See https://api.slack.com/docs/message-formatting
      def payload_for_failed
        {
          attachments: [{
            author_name: deployer,
            color: 'danger',
            fields: [{
              title: last_commit,
              value: '_Deployment failed !_',
              short: true
            }, {
              title: 'Environment',
              value: stage,
              short: true
            }, {
              title: 'Branch',
              value: branch,
              short: true
            }, {
              title: 'Time',
              value: elapsed_time,
              short: true
            }],
            fallback: super[:text],
            ts: Time.now.to_i
          }]
        }
      end

      # Override the deployer helper to pull the best name available (git, password file, env vars).
      # See https://github.com/phallstrom/slackistrano/blob/master/lib/slackistrano/messaging/helpers.rb
      def deployer
        name = `git config user.name`.strip
        name = nil if name.empty?
        name ||= ENV['CI_DEPLOY_USER'] || ENV['USER'] || ENV['USERNAME']
        name
      end

      def last_commit
        `git log -1 --pretty=%B | cat`.lines.first
      end
    end
  end
end
