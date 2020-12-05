# frozen_string_literal: true

require 'swagger_helper'

describe 'Suggestions', swagger_doc: 'v1/swagger.json' do
  path '/v1/suggestions' do
    let(:game_profile) { create(:league_of_legends_game_profile) }
    let(:user) { game_profile.user }
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

    get 'Getting Suggestions' do
      tags 'Suggestions'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :game_profile_id,
                in: :query,
                required: true,
                description: 'Suggestions target',
                type: :string,
                format: :uuid

      response '200', 'Retrieved Suggestions' do
        let(:game_profile_id) { game_profile.id }

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
        let(:game_profile_id) { game_profile.id }

        schema '$ref': '#/definitions/unauthorized_body'

        run_test!
      end

      response '404', 'Not Found' do
        let(:game_profile_id) { '' }

        schema '$ref': '#/definitions/not_found_body'

        run_test!
      end
    end
  end
end
