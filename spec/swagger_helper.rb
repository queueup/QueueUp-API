# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.to_s + '/docs'

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:to_swagger' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'authentication/swagger.json' => {
      swagger: '2.0',
      info: {
        title: 'Authentication API',
        version: 'v1'
      },
      paths: {}
    },
    'fortnite/swagger.json' => {
      swagger: '2.0',
      info: {
        title: 'Fortnite API',
        version: 'v1'
      },
      paths: {}
    },
    'league_of_legends/swagger.json' => {
      swagger: '2.0',
      info: {
        title: 'League of Legends API',
        version: 'v1'
      },
      paths: {}
    },
    'v1/swagger.json' => {
      swagger: '2.0',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      definitions: {
        badge: {
          type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            level: { type: :integer, 'x-nullable': true },
            description: { type: :string, 'x-nullable': true },
            custom_fields: { type: :object, 'x-nullable': true }
          }
        },
        device: {
          type: :object,
          properties: {
            id: { type: :string, format: :uuid },
            player_id: { type: :string },
            user: { '$ref': '#/definitions/user' }
          }
        },
        fortnite_profile: {
          type: :object,
          properties: {
            id: { type: :string, format: :uuid },
            handle: { type: :string },
            platform: { type: :string },
            picture_url: { type: :string, 'x-nullable': true },
            description: { type: :string, 'x-nullable': true },
            duo: { type: :boolean, 'x-nullable': true },
            squad: { type: :boolean, 'x-nullable': true },
            fun: { type: :boolean, 'x-nullable': true },
            try_hard: { type: :boolean, 'x-nullable': true },
            kills_solo: { type: :number, 'x-nullable': true },
            kills_duo: { type: :number, 'x-nullable': true },
            kills_squad: { type: :number, 'x-nullable': true },
            kd_solo: { type: :number, 'x-nullable': true },
            kd_duo: { type: :number, 'x-nullable': true },
            kd_squad: { type: :number, 'x-nullable': true },
            played_solo: { type: :number, 'x-nullable': true },
            played_duo: { type: :number, 'x-nullable': true },
            played_squad: { type: :number, 'x-nullable': true },
            scout_updated_at: { type: :string, format: 'date-time' },
            game_profile_id: { type: :string, format: :uuid, 'x-nullable': true }
          }
        },
        game_profile: {
          type: :object,
          properties: {
            id: { type: :string, format: :uuid },
            resource_type: { type: :string, enum: %i[LeagueOfLegendsProfile FortniteProfile] },
            scores: { type: :object },
            resource: {
              anyOf: [
                { '$ref': '#/definitions/league_of_legends_profile' },
                { '$ref': '#/definitions/fortnite_profile' }
              ]
            },
            user: { '$ref': '#/definitions/user_light' }
          }
        },
        game_profile_report: {
          type: :object,
          properties: {
            game_profile_id: { type: :string, format: :uuid },
            target_profile_id: { type: :string, format: :uuid },
            reason: { type: :string, enum: %i[spam bot offensive other] },
            description: { type: :string }
          }
        },
        game_profile_score: {
          type: :object,
          properties: {
            id: { type: :string, format: :uuid },
            score: { '$ref': '#/definitions/score' }
          }
        },
        interaction: {
          type: :object,
          properties: {
            id: { type: :string, format: :uuid },
            liked: { type: :boolean },
            game_profile: { '$ref': '#/definitions/game_profile' },
            target: { '$ref': '#/definitions/game_profile' }
          }
        },
        league_of_legends_position: {
          type: :object,
          properties: {
            id: { type: :string },
            rank: { type: :string },
            queue_type: { type: :string },
            hot_streak: { type: :string },
            wins: { type: :string },
            veteran: { type: :string },
            losses: { type: :string },
            fresh_blood: { type: :string },
            league_id: { type: :string },
            player_or_team_name: { type: :string },
            inactive: { type: :string },
            player_or_team_id: { type: :string },
            league_name: { type: :string },
            tier: { type: :string },
            league_point: { type: :string }
          }
        },
        league_of_legends_profile: {
          type: :object,
          properties: {
            id: { type: :string, format: :uuid },
            summoner_name: { type: :string },
            region: { type: :string },
            champions: {
              type: :array,
              items: { type: :string }
            },
            roles: {
              type: :array,
              items: { type: :string }
            },
            profile_icon_id: { type: :integer },
            profile_icon_url: { type: :string },
            summoner_level: { type: :integer },
            description: { type: :string, 'x-nullable': true },
            riot_updated_at: { type: :string, format: 'date-time' },
            game_profile_id: { type: :string, format: :uuid, 'x-nullable': true }
          }
        },
        match: {
          type: :object,
          properties: {
            id: { type: :string, format: :uuid },
            last_message: {
              oneOf: [
                { '$ref': '#/definitions/message' },
                { type: :null }
              ]
            },
            game_profiles: {
              type: :array,
              items: { '$ref': '#/definitions/game_profile' }
            },
            match_memberships: {
              type: :array,
              items: { '$ref': '#/definitions/match_membership' }
            }
          }
        },
        match_membership: {
          type: :object,
          properties: {
            id: { type: :string, format: :uuid },
            game_profile: { '$ref': '#/definitions/game_profile' },
            match_id: { type: :string, format: :uuid },
            messages_read_at: { type: :string, format: 'date-time', 'x-nullable': true }
          }
        },
        message: {
          type: :object,
          properties: {
            id: { type: :string, format: :uuid },
            content: { type: :string },
            created_at: { type: :string, format: 'date-time' },
            match_id: { type: :string, format: :uuid },
            game_profile: { '$ref': '#/definitions/game_profile' },
            match_memberships: { type: :array, items: { '$ref': '#/definitions/match_membership' } }
          }
        },
        score: {
          type: :object,
          properties: {
            id: { type: :string, format: :uuid },
            key: { type: :string },
            positive: { type: :boolean }
          }
        },
        user: {
          type: :object,
          properties: {
            id: { type: :string, format: :uuid },
            badges: {
              type: :array,
              items: { '$ref': '#/definitions/badge' }
            },
            facebook_id: { type: :string, 'x-nullable': true },
            google_id: { type: :string, 'x-nullable': true },
            game_profiles: {
              type: :array,
              items: { '$ref': '#/definitions/game_profile' }
            },
            favorite_badge: { type: :string, 'x-nullable': true },
            locales: {
              type: :array,
              items: { type: :string }
            }
          }
        },
        user_light: {
          type: :object,
          properties: {
            badges: {
              type: :array,
              items: { '$ref': '#/definitions/badge' }
            },
            favorite_badge: { type: :string, 'x-nullable': true },
            locales: {
              type: :array,
              items: { type: :string }
            }
          }
        },
        not_found_body: {
          type: :string, 'x-nullable': true, example: ''
        },
        unauthorized_body: {
          anyOf: [
            {
              type: :object,
              properties: {
                errors: {
                  type: :array,
                  items: { type: :string }
                }
              }
            },
            { type: :string, 'x-nullable': true }
          ]
        }
      }
    }
  }
end
