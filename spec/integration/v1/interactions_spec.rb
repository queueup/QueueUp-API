# frozen_string_literal: true

require 'swagger_helper'

describe 'Interactions', swagger_doc: 'v1/swagger.json' do
  path '/v1/interactions' do
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

    post 'Creating interactions' do
      tags 'Interactions'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :interaction,
                type: :object,
                description: 'Interaction object',
                in: :body,
                properties: {
                  game_profile_id: { type: :string, format: :uuid },
                  target_id: { type: :string, format: :uuid },
                  liked: { type: :boolean }
                },
                example: {
                  game_profile_id: '00112233-4455-6677-8899-aabbccddeeff',
                  target_id: '00112233-4455-6677-8899-aabbccddeeff',
                  liked: true
                }

      response '201', 'Created interaction' do
        let(:interaction) do
          {
            game_profile_id: create(:league_of_legends_game_profile, user: user).id,
            target_id: create(:league_of_legends_game_profile).id,
            liked: true
          }
        end

        schema '$ref': '#/definitions/interaction'

        run_test!
      end

      response '401', 'Unauthorized' do
        let(:'Access-Token') { nil }
        let(:'Token-Type') { nil }
        let(:Client) { nil }
        let(:Expiry) { nil }
        let(:Uid) { nil }
        let(:interaction) do
          {
            game_profile_id: create(:league_of_legends_game_profile, user: user).id,
            target_id: create(:league_of_legends_game_profile).id,
            liked: true
          }
        end

        schema '$ref': '#/definitions/unauthorized_body'

        run_test!
      end

      response '403', 'Forbidden' do
        let(:interaction) do
          {
            game_profile_id: nil,
            target_id: create(:league_of_legends_game_profile).id,
            liked: true
          }
        end

        schema type: :string

        run_test!
      end

      response '422', 'Unprocessable entity' do
        let(:interaction) do
          {
            game_profile_id: create(:league_of_legends_game_profile, user: user).id,
            target_id: nil,
            liked: true
          }
        end

        schema type: :object

        run_test!
      end
    end
  end
end
