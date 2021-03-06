# frozen_string_literal: true

require 'swagger_helper'

describe 'Champions', swagger_doc: 'league_of_legends/swagger.json' do
  path '/league_of_legends/champions' do
    get 'Getting champions' do
      consumes 'application/json'
      produces 'application/json'

      response '200', 'Getting Champions' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   version: { type: :string },
                   id: { type: :string },
                   key: { type: :string },
                   name: { type: :string },
                   title: { type: :string },
                   blurb: { type: :string },
                   info: {
                     type: :object,
                     properties: {
                       attack: { type: :number },
                       defense: { type: :number },
                       magic: { type: :number },
                       difficulty: { type: :number }
                     }
                   },
                   image: {
                     type: :object,
                     properties: {
                       full: { type: :string },
                       sprite: { type: :string },
                       group: { type: :string },
                       x: { type: :number },
                       y: { type: :number },
                       w: { type: :number },
                       h: { type: :number }
                     }
                   },
                   tags: {
                     type: :array,
                     items: { type: :string }
                   },
                   partype: { type: :string },
                   stats: {
                     type: :object,
                     properties: {
                       hp: { type: :number },
                       hpperlevel: { type: :number },
                       mp: { type: :number },
                       mpperlevel: { type: :number },
                       movespeed: { type: :number },
                       armor: { type: :number },
                       armorperlevel: { type: :number },
                       spellblock: { type: :number },
                       spellblockperlevel: { type: :number },
                       attackrange: { type: :number },
                       hpregen: { type: :number },
                       hpregenperlevel: { type: :number },
                       mpregen: { type: :number },
                       mpregenperlevel: { type: :number },
                       crit: { type: :number },
                       critperlevel: { type: :number },
                       attackdamage: { type: :number },
                       attackdamageperlevel: { type: :number },
                       attackspeedperlevel: { type: :number },
                       attackspeed: { type: :number }
                     }
                   },
                   icon: { type: :string },
                   splash: { type: :string }
                 }
               }

        run_test!
      end
    end
  end
end
