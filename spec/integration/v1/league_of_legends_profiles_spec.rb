# frozen_string_literal: true

require 'swagger_helper'

describe 'League of Legends Profiles', swagger_doc: 'v1/swagger.json' do
  path '/v1/league_of_legends_profiles' do
    let(:user) { create(:user) }
    let(:auth_token) { user.create_new_auth_token }
    let(:'Access-Token') { auth_token['access-token'] }
    let(:'Token-Type') { auth_token['token-type'] }
    let(:Client) { auth_token['client'] }
    let(:Expiry) { auth_token['expiry'] }
    let(:Uid) { auth_token['uid'] }

    parameter name: 'Access-Token',
              in: :header,
              required: true,
              description: "Session's Access-Token",
              type: :string
    parameter name: 'Token-Type',
              in: :header,
              required: true,
              description: "Session's Token-Type",
              type: :string
    parameter name: 'Client',
              in: :header,
              required: true,
              description: "Session's Client",
              type: :string
    parameter name: 'Expiry',
              in: :header,
              required: true,
              description: "Session's Expiry",
              type: :string
    parameter name: 'Uid',
              in: :header,
              required: true,
              description: "Session's Uid",
              type: :string

    post 'Creating LoL Profile' do
      tags 'League of Legends', 'League of Legends Profiles'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :league_of_legends_profile,
                type: :object,
                description: 'LoL Profile object',
                in: :body,
                properties: {
                  summoner_name: { type: :string },
                  region: { type: :string }
                },
                example: {
                  summoner_name: 'Sarcastique',
                  region: 'EUW'
                }

      response '201', 'Created LoL Profile' do
        let(:league_of_legends_profile) do
          {
            summoner_name: 'Sarcastique',
            region: 'EUW'
          }
        end

        schema '$ref': '#/definitions/league_of_legends_profile'

        run_test!
      end

      response '404', 'Not found' do
        let(:league_of_legends_profile) do
          {
            summoner_name: nil,
            region: 'EUW'
          }
        end

        schema '$ref': '#/definitions/not_found_body'

        run_test!
      end
    end
  end

  path '/v1/league_of_legends_profiles/{id}' do
    let(:user) { create(:user) }
    let(:auth_token) { user.create_new_auth_token }
    let(:'Access-Token') { auth_token['access-token'] }
    let(:'Token-Type') { auth_token['token-type'] }
    let(:Client) { auth_token['client'] }
    let(:Expiry) { auth_token['expiry'] }
    let(:Uid) { auth_token['uid'] }
    let(:profile) { create(:league_of_legends_game_profile, user: user) }
    let(:id) { profile.resource.id }

    parameter name: 'Access-Token',
              in: :header,
              required: true,
              description: "Session's Access-Token",
              type: :string
    parameter name: 'Token-Type',
              in: :header,
              required: true,
              description: "Session's Token-Type",
              type: :string
    parameter name: 'Client',
              in: :header,
              required: true,
              description: "Session's Client",
              type: :string
    parameter name: 'Expiry',
              in: :header,
              required: true,
              description: "Session's Expiry",
              type: :string
    parameter name: 'Uid',
              in: :header,
              required: true,
              description: "Session's Uid",
              type: :string

    parameter name: :id,
              in: :path,
              required: true,
              description: 'LoL Profile id',
              type: :string,
              format: :uuid

    get 'Getting LoL Profile' do
      tags 'League of Legends', 'League of Legends Profiles'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'LoL Profile retrieved' do
        schema '$ref': '#/definitions/league_of_legends_profile'

        run_test!
      end

      response '401', 'Unauthorized' do
        let(:'Access-Token') { nil }
        let(:'Token-Type') { nil }
        let(:Client) { nil }
        let(:Expiry) { nil }
        let(:Uid) { nil }

        schema '$ref': '#/definitions/unauthorized_body'

        run_test!
      end

      response '404', 'Not found' do
        let(:id) { '0' }

        schema '$ref': '#/definitions/not_found_body'

        run_test!
      end
    end

    patch 'Updating LoL Profile' do
      tags 'League of Legends', 'League of Legends Profiles'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :league_of_legends_profile,
                type: :object,
                description: 'LoL Profile object',
                in: :body,
                properties: {
                  description: { type: :string, 'x-nullable': true },
                  champions: {
                    type: :array,
                    items: { type: :string }
                  },
                  roles: {
                    type: :array,
                    items: { type: :string }
                  }
                },
                example: {
                  description: 'I am Sarcastique',
                  champions: %w[121 132 12],
                  roles: %w[TOP BOTTOM]
                }

      response '200', 'LoL Profile updated' do
        let(:league_of_legends_profile) do
          {
            description: 'I am Sarcastique',
            champions: %w[121 132 12],
            roles: %w[TOP BOTTOM]
          }
        end

        schema '$ref': '#/definitions/league_of_legends_profile'

        run_test!
      end

      response '401', 'Unauthorized' do
        let(:'Access-Token') { nil }
        let(:'Token-Type') { nil }
        let(:Client) { nil }
        let(:Expiry) { nil }
        let(:Uid) { nil }
        let(:league_of_legends_profile) do
          {
            description: 'I am Sarcastique',
            champions: %w[121 132 12],
            roles: %w[TOP BOTTOM]
          }
        end

        schema '$ref': '#/definitions/unauthorized_body'

        run_test!
      end
    end

    delete 'Deleting LoL Profile' do
      tags 'League of Legends', 'League of Legends Profiles'
      consumes 'application/json'
      produces 'application/json'

      response '204', 'LoL profile destroyed' do
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:'Access-Token') { nil }
        let(:'Token-Type') { nil }
        let(:Client) { nil }
        let(:Expiry) { nil }
        let(:Uid) { nil }

        schema '$ref': '#/definitions/unauthorized_body'

        run_test!
      end

      response '404', 'Not found' do
        let(:id) { '0' }

        schema '$ref': '#/definitions/not_found_body'

        run_test!
      end
    end
  end

  path '/v1/league_of_legends_profiles/{id}/reload' do
    let(:user) { create(:user) }
    let(:auth_token) { user.create_new_auth_token }
    let(:'Access-Token') { auth_token['access-token'] }
    let(:'Token-Type') { auth_token['token-type'] }
    let(:Client) { auth_token['client'] }
    let(:Expiry) { auth_token['expiry'] }
    let(:Uid) { auth_token['uid'] }
    let(:profile) { create(:league_of_legends_game_profile, user: user) }
    let(:id) { profile.resource.id }

    parameter name: 'Access-Token',
              in: :header,
              required: true,
              description: "Session's Access-Token",
              type: :string
    parameter name: 'Token-Type',
              in: :header,
              required: true,
              description: "Session's Token-Type",
              type: :string
    parameter name: 'Client',
              in: :header,
              required: true,
              description: "Session's Client",
              type: :string
    parameter name: 'Expiry',
              in: :header,
              required: true,
              description: "Session's Expiry",
              type: :string
    parameter name: 'Uid',
              in: :header,
              required: true,
              description: "Session's Uid",
              type: :string

    parameter name: :id,
              in: :path,
              required: true,
              description: 'LoL Profile id',
              type: :string,
              format: :uuid

    patch 'Reloading LoL Profile' do
      tags 'League of Legends', 'League of Legends Profiles'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'LoL Profile updated' do
        schema '$ref': '#/definitions/league_of_legends_profile'

        run_test!
      end

      response '401', 'Unauthorized' do
        let(:'Access-Token') { nil }
        let(:'Token-Type') { nil }
        let(:Client) { nil }
        let(:Expiry) { nil }
        let(:Uid) { nil }

        schema '$ref': '#/definitions/unauthorized_body'

        run_test!
      end

      response '404', 'Not found' do
        let(:id) { '0' }

        schema '$ref': '#/definitions/not_found_body'

        run_test!
      end
    end
  end

  path '/v1/league_of_legends_profiles/{region}/{summoner_name}' do
    let(:region) { 'EUW' }
    let(:summoner_name) { 'Sarcastique' }

    parameter name: :region,
              in: :path,
              required: true,
              description: 'LoL Profile region',
              type: :string
    parameter name: :summoner_name,
              in: :path,
              required: true,
              description: 'LoL Profile summoner name',
              type: :string

    get 'Getting LoL Profile' do
      tags 'League of Legends', 'League of Legends Profiles'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'LoL Profile retrieved' do
        schema '$ref': '#/definitions/league_of_legends_profile'

        run_test!
      end
    end
  end
end
