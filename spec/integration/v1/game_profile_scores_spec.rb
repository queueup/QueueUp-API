# frozen_string_literal: true

require 'swagger_helper'

describe 'Game Profile Scores', swagger_doc: 'v1/swagger.json' do
  path '/v1/game_profile_scores' do
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

    get 'Getting game profile scores' do
      tags 'Game Profile Scores', 'Scoring'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :target_game_profile_id,
                type: :string,
                format: :uuid,
                description: 'Filter by target game profile',
                in: :query
      parameter name: :score_id,
                type: :string,
                format: :uuid,
                description: 'Filter by score',
                in: :query

      response '200', 'Retrieved created game profile scores' do
        let(:target_game_profile_id) { '' }
        let(:score_id) { '' }

        schema type: :array,
               items: {
                 type: :object,
                 '$ref': '#/definitions/game_profile_score'
               }

        run_test!
      end

      response '401', 'Unauthorized' do
        let(:'Access-Token') { nil }
        let(:'Token-Type') { nil }
        let(:Client) { nil }
        let(:Expiry) { nil }
        let(:Uid) { nil }
        let(:target_game_profile_id) { '' }
        let(:score_id) { '' }

        schema '$ref': '#/definitions/unauthorized_body'

        run_test!
      end
    end

    post 'Creating game profile score' do
      tags 'Game Profile Scores', 'Scoring'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :game_profile_score,
                in: :body,
                required: true,
                type: :object,
                properties: {
                  game_profile_id: { type: :string, format: :uuid },
                  target_game_profile_id: { type: :string, format: :uuid },
                  score_id: { type: :string, format: :uuid }
                },
                example: {
                  game_profile_id: '00112233-4455-6677-8899-aabbccddeeff',
                  target_game_profile_id: '00112233-4455-6677-8899-aabbccddeeff',
                  score_id: '00112233-4455-6677-8899-aabbccddeeff'
                }

      response '201', 'Game profile score created' do
        let(:game_profile_score) do
          {
            game_profile_id: create(:league_of_legends_game_profile, user: user).id,
            target_game_profile_id: create(:league_of_legends_game_profile).id,
            score_id: create(:score).id
          }
        end

        schema '$ref': '#/definitions/game_profile_score'

        run_test!
      end

      response '401', 'Unauthorized' do
        let(:user) { create(:user) }
        let(:'Access-Token') { nil }
        let(:'Token-Type') { nil }
        let(:Client) { nil }
        let(:Expiry) { nil }
        let(:Uid) { nil }
        let(:game_profile_score) do
          {
            game_profile_id: create(:league_of_legends_game_profile, user: user).id,
            target_game_profile_id: create(:league_of_legends_game_profile).id,
            score_id: create(:score).id
          }
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
        let(:game_profile_score) do
          {
            game_profile_id: create(:league_of_legends_game_profile, user: user).id,
            target_game_profile_id: nil,
            score_id: create(:score).id
          }
        end

        run_test!
      end
    end
  end

  path '/v1/game_profile_scores/{id}' do
    let(:game_profile) { create(:league_of_legends_game_profile) }
    let(:score) { create(:game_profile_score, game_profile: game_profile) }
    let(:user) { game_profile.user }
    let(:auth_token) { user.create_new_auth_token }
    let(:'Access-Token') { auth_token['access-token'] }
    let(:'Token-Type') { auth_token['token-type'] }
    let(:Client) { auth_token['client'] }
    let(:Expiry) { auth_token['expiry'] }
    let(:Uid) { auth_token['uid'] }
    let(:id) { score.id }

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

    get 'Getting game profile score' do
      tags 'Game Profile Scores', 'Scoring'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'Game profile score retrieved' do
        schema '$ref': '#/definitions/game_profile_score'

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

    patch 'Updating game profile score' do
      tags 'Game Profile Scores', 'Scoring'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :game_profile_score,
                in: :body,
                required: true,
                type: :object,
                properties: {
                  game_profile_id: { type: :string, format: :uuid },
                  target_game_profile_id: { type: :string, format: :uuid },
                  score_id: { type: :string, format: :uuid }
                },
                example: {
                  game_profile_id: '00112233-4455-6677-8899-aabbccddeeff',
                  target_game_profile_id: '00112233-4455-6677-8899-aabbccddeeff',
                  score_id: '00112233-4455-6677-8899-aabbccddeeff'
                }

      response '200', 'Game profile score retrieved' do
        let(:game_profile_score) do
          {
            score_id: create(:score).id
          }
        end

        schema '$ref': '#/definitions/game_profile_score'

        run_test!
      end

      response '401', 'Unauthorized' do
        let(:'Access-Token') { nil }
        let(:'Token-Type') { nil }
        let(:Client) { nil }
        let(:Expiry) { nil }
        let(:Uid) { nil }
        let(:game_profile_score) do
          {
            score_id: create(:score).id
          }
        end

        schema '$ref': '#/definitions/unauthorized_body'

        run_test!
      end

      response '404', 'Not found' do
        let(:id) { '0' }
        let(:game_profile_score) { {} }

        schema '$ref': '#/definitions/not_found_body'

        run_test!
      end

      response '422', 'Unprocessable entity' do
        let(:game_profile_score) do
          {
            score_id: nil
          }
        end

        schema type: :object

        run_test!
      end
    end

    delete 'Deleting game profile score' do
      tags 'Game Profile Scores', 'Scoring'
      consumes 'application/json'
      produces 'application/json'

      response '204', 'Game profile score destroyed' do
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
