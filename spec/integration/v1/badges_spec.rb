# frozen_string_literal: true

require 'swagger_helper'

describe 'Badges', swagger_doc: 'v1/swagger.json' do
  path '/v1/badges' do
    get 'Getting badges' do
      tags 'Badges'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'Getting Badges' do
        schema type: :array,
               items: { '$ref' => '#/definitions/badge' },
               example: [{
                 id: 1,
                 name: 'bug-catcher',
                 level: nil,
                 description: nil,
                 custom_fields: nil
               }]

        run_test!
      end
    end
  end

  path '/v1/badges/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Getting single badge' do
      tags 'Badges'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'Badge retrieved' do
        let(:id) { Merit::Badge.first.id }

        schema '$ref' => '#/definitions/badge',
               example: {
                 id: 1,
                 name: 'bug-catcher',
                 level: nil,
                 description: nil,
                 custom_fields: nil
               }

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
