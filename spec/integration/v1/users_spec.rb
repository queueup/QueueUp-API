# frozen_string_literal: true

require 'swagger_helper'

describe 'Users', swagger_doc: 'v1/swagger.json' do
  path '/v1/user' do
    let(:current_user) { create(:user) }
    let(:auth_token) { current_user.create_new_auth_token }
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

    get 'Getting User' do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'User retrieved' do
        schema '$ref': '#/definitions/user'

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
    end

    patch 'Updating User' do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :user,
                type: :object,
                properties: {
                  favorite_badge: { type: :string },
                  locales: {
                    type: :array,
                    items: { type: :string }
                  }
                },
                example: {
                  favorite_badge: '',
                  locales: ['en-GB', 'fr-FR']
                },
                in: :body,
                required: true

      response '200', 'User Updated' do
        let(:user) do
          {
            favorite_badge: '',
            locales: ['en-GB', 'fr-FR']
          }
        end

        schema '$ref': '#/definitions/user'

        run_test!
      end

      response '401', 'Unauthorized' do
        let(:'Access-Token') { nil }
        let(:'Token-Type') { nil }
        let(:Client) { nil }
        let(:Expiry) { nil }
        let(:Uid) { nil }
        let(:user) do
          {
            favorite_badge: '',
            locales: ['en-GB', 'fr-FR']
          }
        end

        schema '$ref': '#/definitions/unauthorized_body'

        run_test!
      end
    end
  end
end
