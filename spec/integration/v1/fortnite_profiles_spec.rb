# frozen_string_literal: true

require 'swagger_helper'

describe 'Fortnite Profiles', swagger_doc: 'v1/swagger.json' do
  path '/v1/fortnite_profiles' do
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

    post 'Creating Fortnite Profile' do
      tags 'Fortnite', 'Fortnite Profiles'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :fortnite_profile,
                type: :object,
                description: 'Fortnite Profile object',
                in: :body,
                properties: {
                  handle: { type: :string }
                },
                example: {
                  handle: 'SofianeG'
                }

      response '201', 'Created Fortnite Profile' do
        let(:fortnite_profile) do
          {
            handle: 'SofianeG'
          }
        end

        schema '$ref': '#/definitions/fortnite_profile'

        run_test!
      end

      response '422', 'Unprocessable Entity' do
        let(:fortnite_profile) do
          {
            handle: nil
          }
        end

        run_test!
      end
    end
  end

  path '/v1/fortnite_profiles/{id}' do
    let(:user) { create(:user) }
    let(:auth_token) { user.create_new_auth_token }
    let(:'Access-Token') { auth_token['access-token'] }
    let(:'Token-Type') { auth_token['token-type'] }
    let(:Client) { auth_token['client'] }
    let(:Expiry) { auth_token['expiry'] }
    let(:Uid) { auth_token['uid'] }
    let(:profile) { create(:fortnite_game_profile, user: user) }
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
              description: 'Fortnite Profile id',
              type: :string,
              format: :uuid

    get 'Getting Fortnite Profile' do
      tags 'Fortnite', 'Fortnite Profiles'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'Fortnite Profile retrieved' do
        schema '$ref': '#/definitions/fortnite_profile'

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

    patch 'Updating Fortnite Profile' do
      tags 'Fortnite', 'Fortnite Profiles'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :fortnite_profile,
                type: :object,
                description: 'Fortnite Profile object',
                in: :body,
                properties: {
                  description: { type: :string, 'x-nullable': true },
                  fun: { type: :boolean }
                },
                example: {
                  description: 'I am SofianeG',
                  fun: true
                }

      response '200', 'Fortnite Profile updated' do
        let(:fortnite_profile) do
          {
            description: 'I am SofianeG',
            fun: true
          }
        end

        schema '$ref': '#/definitions/fortnite_profile'

        run_test!
      end

      response '401', 'Unauthorized' do
        let(:'Access-Token') { nil }
        let(:'Token-Type') { nil }
        let(:Client) { nil }
        let(:Expiry) { nil }
        let(:Uid) { nil }
        let(:fortnite_profile) do
          {
            description: 'I am SofianeG',
            fun: true
          }
        end

        schema '$ref': '#/definitions/unauthorized_body'

        run_test!
      end
    end

    delete 'Deleting Fortnite Profile' do
      tags 'Fortnite', 'Fortnite Profiles'
      consumes 'application/json'
      produces 'application/json'

      response '204', 'Fortnite profile destroyed' do
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

  path '/v1/fortnite_profiles/{id}/reload' do
    let(:user) { create(:user) }
    let(:auth_token) { user.create_new_auth_token }
    let(:'Access-Token') { auth_token['access-token'] }
    let(:'Token-Type') { auth_token['token-type'] }
    let(:Client) { auth_token['client'] }
    let(:Expiry) { auth_token['expiry'] }
    let(:Uid) { auth_token['uid'] }
    let(:profile) { create(:fortnite_game_profile, user: user) }
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
              description: 'Fortnite Profile id',
              type: :string,
              format: :uuid

    patch 'Reloading Fortnite Profile' do
      tags 'Fortnite', 'Fortnite Profiles'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'Fortnite Profile updated' do
        schema '$ref': '#/definitions/fortnite_profile'

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

  path '/v1/fortnite_profiles/{id}/by_handle' do
    let(:id) { 'SofianeG' }

    parameter name: :id,
              in: :path,
              required: true,
              description: 'Fortnite Profile Handle',
              type: :string

    get 'Getting Fortnite Profile' do
      tags 'Fortnite', 'Fortnite Profiles'
      consumes 'application/json'
      produces 'application/json'

      response '201', 'Fortnite Profile retrieved' do
        schema '$ref': '#/definitions/fortnite_profile'

        run_test!
      end
    end
  end
end
