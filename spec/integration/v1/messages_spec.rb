# frozen_string_literal: true

require 'swagger_helper'

describe 'Messages', swagger_doc: 'v1/swagger.json' do
  path '/v1/messages' do
    let(:user) { create(:user) }
    let(:game_profile) { create(:league_of_legends_game_profile, user: user) }
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

    get 'Getting Messages' do
      tags 'Messages'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :match_id,
                type: :string,
                format: :uuid,
                description: 'Filter by match',
                in: :query

      response '200', 'Retrieved messages' do
        let(:match_id) { '' }

        schema type: :array,
               items: {
                 type: :object,
                 '$ref': '#/definitions/message'
               }

        run_test!
      end

      response '401', 'Unauthorized' do
        let(:'Access-Token') { nil }
        let(:'Token-Type') { nil }
        let(:Client) { nil }
        let(:Expiry) { nil }
        let(:Uid) { nil }
        let(:match_id) { '' }

        schema '$ref': '#/definitions/unauthorized_body'

        run_test!
      end
    end

    post 'Creating Message' do
      tags 'Messages'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :message,
                in: :body,
                required: true,
                type: :object,
                properties: {
                  game_profile_id: { type: :string, format: :uuid },
                  content: { type: :string },
                  match_id: { type: :string, format: :uuid }
                },
                example: {
                  game_profile_id: '00112233-4455-6677-8899-aabbccddeeff',
                  content: 'This is the message',
                  score_id: '00112233-4455-6677-8899-aabbccddeeff'
                }

      response '201', 'Message created' do
        let(:message) do
          {
            game_profile_id: game_profile.id,
            content: 'This is a message',
            match_id: create(:match_membership, game_profile: game_profile).match_id
          }
        end

        schema '$ref': '#/definitions/message'

        run_test!
      end

      response '401', 'Unauthorized' do
        let(:user) { create(:user) }
        let(:'Access-Token') { nil }
        let(:'Token-Type') { nil }
        let(:Client) { nil }
        let(:Expiry) { nil }
        let(:Uid) { nil }
        let(:message) do
          {
            game_profile_id: game_profile.id,
            content: 'This is a message',
            match_id: create(:match_membership, game_profile: game_profile).match_id
          }
        end

        schema '$ref': '#/definitions/unauthorized_body'

        run_test!
      end

      response '403', 'Forbidden' do
        let(:user) { create(:user) }
        let(:auth_token) { user.create_new_auth_token }
        let(:'Access-Token') { auth_token['access-token'] }
        let(:'Token-Type') { auth_token['token-type'] }
        let(:Client) { auth_token['client'] }
        let(:Expiry) { auth_token['expiry'] }
        let(:Uid) { auth_token['uid'] }
        let(:message) do
          {
            game_profile_id: game_profile.id,
            content: 'This is a message',
            match_id: nil
          }
        end

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
        let(:message) do
          {
            game_profile_id: game_profile.id,
            content: '',
            match_id: create(:match_membership, game_profile: game_profile).match_id
          }
        end

        run_test!
      end
    end
  end

  path '/v1/messages/{id}' do
    let(:game_profile) { create(:league_of_legends_game_profile) }
    let(:message) { create(:message, match: create(:match_membership, game_profile: game_profile).match) }
    let(:user) { game_profile.user }
    let(:auth_token) { user.create_new_auth_token }
    let(:'Access-Token') { auth_token['access-token'] }
    let(:'Token-Type') { auth_token['token-type'] }
    let(:Client) { auth_token['client'] }
    let(:Expiry) { auth_token['expiry'] }
    let(:Uid) { auth_token['uid'] }
    let(:id) { message.id }

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

    get 'Getting Message' do
      tags 'Messages'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'Message retrieved' do
        schema '$ref': '#/definitions/message'

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

    # delete 'Deleting Message' do
    #   tags 'Messages'
    #   consumes 'application/json'
    #   produces 'application/json'

    #   response '204', 'Message destroyed' do
    #     run_test!
    #   end

    #   response '401', 'Unauthorized' do
    #     let(:'Access-Token') { nil }
    #     let(:'Token-Type') { nil }
    #     let(:Client) { nil }
    #     let(:Expiry) { nil }
    #     let(:Uid) { nil }

    #     schema '$ref': '#/definitions/unauthorized_body'

    #     run_test!
    #   end

    #   response '404', 'Not found' do
    #     let(:id) { '0' }

    #     schema '$ref': '#/definitions/not_found_body'

    #     run_test!
    #   end
    # end
  end
end
