# frozen_string_literal: true

require 'swagger_helper'

describe 'Assets', swagger_doc: 'fortnite/swagger.json' do
  path '/fortnite/assets/avatars' do
    get 'Getting avatars' do
      consumes 'application/json'
      produces 'application/json'

      response '200', 'Getting Avatars' do
        schema type: :object,
               properties: {
                 base_path: { type: :string },
                 avatars: { type: :array, items: { type: :string } }
               }

        run_test!
      end
    end
  end
end
