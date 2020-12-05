# frozen_string_literal: true

require 'swagger_helper'

describe 'Matches Scores', swagger_doc: 'v1/swagger.json' do
  path '/v1/matches' do
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

    get 'Getting Matches' do
      tags 'Matches'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :game_profile_id,
                type: :string,
                format: :uuid,
                description: 'Filter by game profile',
                in: :query

      response '200', 'Retrieved matches' do
        let(:game_profile_id) { '' }

        schema type: :array,
               items: {
                 type: :object,
                 '$ref': '#/definitions/match'
               }

        run_test!
      end

      response '401', 'Unauthorized' do
        let(:'Access-Token') { nil }
        let(:'Token-Type') { nil }
        let(:Client) { nil }
        let(:Expiry) { nil }
        let(:Uid) { nil }
        let(:game_profile_id) { '' }

        schema '$ref': '#/definitions/unauthorized_body'

        run_test!
      end
    end
  end

  path '/v1/matches/{id}' do
    let(:game_profile) { create(:league_of_legends_game_profile) }
    let(:match) { create(:match_membership, game_profile: game_profile).match }
    let(:user) { game_profile.user }
    let(:auth_token) { user.create_new_auth_token }
    let(:'Access-Token') { auth_token['access-token'] }
    let(:'Token-Type') { auth_token['token-type'] }
    let(:Client) { auth_token['client'] }
    let(:Expiry) { auth_token['expiry'] }
    let(:Uid) { auth_token['uid'] }
    let(:id) { match.id }

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

    get 'Getting match' do
      tags 'Matches'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'Match retrieved' do
        schema '$ref': '#/definitions/match'

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

    delete 'Deleting match' do
      tags 'Matches'
      consumes 'application/json'
      produces 'application/json'

      response '204', 'Match destroyed' do
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
