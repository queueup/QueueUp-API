# frozen_string_literal: true

require 'swagger_helper'

describe 'Game Profiles', swagger_doc: 'v1/swagger.json' do
  path '/v1/game_profiles' do
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

    get 'Getting game profiles' do
      tags 'Game Profiles'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :resource_type,
                type: :string,
                format: :uuid,
                description: 'Filter by resource type (LeagueOfLegendsProfile...)',
                in: :query

      response '200', 'Retrieved own game profiles' do
        let(:resource_type) { '' }

        schema type: :array,
               items: {
                 type: :object,
                 '$ref': '#/definitions/game_profile'
               }

        run_test!
      end

      response '401', 'Unauthorized' do
        let(:'Access-Token') { nil }
        let(:'Token-Type') { nil }
        let(:Client) { nil }
        let(:Expiry) { nil }
        let(:Uid) { nil }
        let(:resource_type) { '' }

        schema '$ref': '#/definitions/unauthorized_body'

        run_test!
      end
    end
  end

  path '/v1/game_profiles/{id}' do
    let(:game_profile) { create(:league_of_legends_game_profile) }
    let(:user) { game_profile.user }
    let(:auth_token) { user.create_new_auth_token }
    let(:'Access-Token') { auth_token['access-token'] }
    let(:'Token-Type') { auth_token['token-type'] }
    let(:Client) { auth_token['client'] }
    let(:Expiry) { auth_token['expiry'] }
    let(:Uid) { auth_token['uid'] }
    let(:id) { game_profile.id }

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

    parameter name: :id, in: :path, type: :string, format: :uuid

    get 'Getting game profile' do
      tags 'Game Profiles'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'Game profile retrieved' do
        schema '$ref': '#/definitions/game_profile'

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

    delete 'Deleting game profile' do
      tags 'Game Profiles'
      consumes 'application/json'
      produces 'application/json'

      response '204', 'Game profile destroyed' do
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
end
