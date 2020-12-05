# frozen_string_literal: true

require 'swagger_helper'

describe 'Devices', swagger_doc: 'v1/swagger.json' do
  path '/v1/devices' do
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

    get 'Getting Devices' do
      tags 'Devices'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'Getting Devices' do
        schema type: :array,
               items: { '$ref' => '#/definitions/device' }

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

    post 'Creating Device' do
      tags 'Devices'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :device,
                in: :body,
                required: true,
                type: :object,
                properties: {
                  player_id: { type: :string }
                },
                example: {
                  player_id: '00112233445566778899aabbccddeeff'
                }

      response '201', 'Device created' do
        let(:device) do
          {
            player_id: '00112233445566778899aabbccddeeff'
          }
        end

        schema '$ref': '#/definitions/device'

        run_test!
      end

      response '401', 'Unauthorized' do
        let(:user) { create(:user) }
        let(:'Access-Token') { nil }
        let(:'Token-Type') { nil }
        let(:Client) { nil }
        let(:Expiry) { nil }
        let(:Uid) { nil }
        let(:device) do
          {
            player_id: '00112233445566778899aabbccddeeff'
          }
        end

        schema '$ref': '#/definitions/unauthorized_body'

        run_test!
      end

      response '422', 'Unprocessable entity' do
        let(:device) do
          {
            player_id: nil
          }
        end

        run_test!
      end
    end
  end

  path '/v1/devices/{id}' do
    let(:user) { create(:user) }
    let(:device) { create(:device, user: user) }
    let(:auth_token) { user.create_new_auth_token }
    let(:'Access-Token') { auth_token['access-token'] }
    let(:'Token-Type') { auth_token['token-type'] }
    let(:Client) { auth_token['client'] }
    let(:Expiry) { auth_token['expiry'] }
    let(:Uid) { auth_token['uid'] }
    let(:id) { device.id }

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

    parameter name: :id, in: :path, type: :integer

    get 'Getting Device' do
      tags 'Devices'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'Device retrieved' do
        schema '$ref' => '#/definitions/device'

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
        let(:id) { 0 }

        schema '$ref': '#/definitions/not_found_body'

        run_test!
      end
    end

    delete 'Deleting Device' do
      tags 'Devices'
      consumes 'application/json'
      produces 'application/json'

      response '204', 'Device destroyed' do
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
        let(:id) { 0 }

        schema '$ref': '#/definitions/not_found_body'

        run_test!
      end
    end
  end
end
