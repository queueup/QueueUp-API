# frozen_string_literal: true

require 'swagger_helper'

describe 'Game Profile Reports', swagger_doc: 'v1/swagger.json' do
  path '/v1/game_profile_reports' do
    post 'Creating a game profile report' do
      tags 'Game Profile Reports', 'Reports'
      consumes 'application/json'
      produces 'application/json'

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
      parameter name: :game_profile_report,
                in: :body,
                required: true,
                '$ref': '#/definitions/game_profile_report',
                example: {
                  game_profile_id: '00112233-4455-6677-8899-aabbccddeeff',
                  target_profile_id: '00112233-4455-6677-8899-aabbccddeeff',
                  reason: 'spam|bot|offensive|other',
                  description: 'Random description'
                }

      response '201', 'Report created' do
        let(:user) { create(:user) }
        let(:auth_token) { user.create_new_auth_token }
        let(:'Access-Token') { auth_token['access-token'] }
        let(:'Token-Type') { auth_token['token-type'] }
        let(:Client) { auth_token['client'] }
        let(:Expiry) { auth_token['expiry'] }
        let(:Uid) { auth_token['uid'] }
        let(:game_profile_report) do
          attributes_for(:game_profile_report,
                         target_profile_id: create(:league_of_legends_game_profile).id,
                         game_profile_id: create(:league_of_legends_game_profile, user: user).id)
        end

        schema '$ref': '#/definitions/game_profile_report'

        run_test!
      end

      response '401', 'Unauthorized' do
        let(:user) { create(:user) }
        let(:auth_token) { user.create_new_auth_token }
        let(:'Access-Token') { nil }
        let(:'Token-Type') { nil }
        let(:Client) { nil }
        let(:Expiry) { nil }
        let(:Uid) { nil }
        let(:game_profile_report) do
          attributes_for(:game_profile_report,
                         target_profile_id: create(:league_of_legends_game_profile).id,
                         game_profile_id: create(:league_of_legends_game_profile, user: user).id)
        end

        schema '$ref': '#/definitions/unauthorized_body'

        run_test!
      end

      response '422', 'Unprocessable entity' do
        let(:user) { create(:user) }
        let(:auth_token) { user.create_new_auth_token }
        let(:'Access-Token') { auth_token['access-token'] }
        let(:'Token-Type') { auth_token['token-type'] }
        let(:Client) { auth_token['client'] }
        let(:Expiry) { auth_token['expiry'] }
        let(:Uid) { auth_token['uid'] }
        let(:game_profile_report) do
          attributes_for(:game_profile_report,
                         target_profile_id: nil,
                         game_profile_id: create(:league_of_legends_game_profile, user: user).id)
        end

        run_test!
      end
    end
  end
end
