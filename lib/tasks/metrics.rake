# frozen_string_literal: true

def format_metric(metric)
  "#{metric.count} (#{format('%+d', metric.where('created_at > ?', Time.zone.now - 1.day).count)})"
end

namespace :metrics do
  desc 'Send report to Discord'
  task discord_report: :environment do
    require 'sidekiq/api'

    requested_metrics = [
      {
        name: 'Users',
        query: User
      },
      {
        name: 'GameProfiles',
        query: GameProfile
      },
      {
        name: 'LeagueOfLegendsProfiles',
        query: LeagueOfLegendsProfile
      },
      {
        name: 'FortniteProfiles',
        query: FortniteProfile
      },
      {
        name: 'Interactions (positive)',
        query: Interaction.where(liked: true)
      },
      {
        name: 'Interactions (negative)',
        query: Interaction.where(liked: false)
      },
      {
        name: 'Matches',
        query: Match
      },
      {
        name: 'Messages',
        query: Message
      }
    ]
    discord = DiscordWebhook.new(ENV['DISCORD_METRICS_WEBHOOK_URL'])
    discord.send(
      content: "Hey ! :wave: \n Here are today's stats !",
      embeds: [
        {
          color:     8_311_585,
          type: :rich,
          fields:    requested_metrics.map do |metric|
                       {
                         inline: true,
                         name:   metric[:name],
                         value:  format_metric(metric[:query])
                       }
                     end
        },
        {
          color: 16_056_407,
          type: :rich,
          fields: [
            {
              inline: true,
              name: 'Sidekiq Queue',
              value: Sidekiq::Queue.new.size
            },
            {
              inline: true,
              name: 'Sidekiq RetrySet',
              value: Sidekiq::RetrySet.new.size
            },
            {
              inline: true,
              name: 'Riot API Version',
              value: RIOT_DDRAGON_VERSION
            }
          ]
        }
      ]
    )
  end
end
