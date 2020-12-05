# frozen_string_literal: true

require 'swagger_helper'

describe 'Scores', swagger_doc: 'v1/swagger.json' do
  path '/v1/scores' do
    get 'Getting Scores' do
      tags 'Scores', 'Scoring'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'Retrieved scores' do
        schema type: :array,
               items: {
                 type: :object,
                 '$ref': '#/definitions/score'
               }

        run_test!
      end
    end
  end

  path '/v1/scores/{id}' do
    let(:id) { create(:score).id }

    parameter name: :id, in: :path, type: :string, format: :uuid

    get 'Getting Score' do
      tags 'Scores', 'Scoring'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'Score retrieved' do
        schema '$ref': '#/definitions/score'

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
