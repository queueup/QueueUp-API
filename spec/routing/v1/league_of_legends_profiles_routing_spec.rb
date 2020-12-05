# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::LeagueOfLegendsProfilesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/v1/league_of_legends_profiles').not_to route_to('v1/league_of_legends_profiles#index')
    end

    it 'routes to #show' do
      expect(get: '/v1/league_of_legends_profiles/1').to route_to('v1/league_of_legends_profiles#show', id: '1')
    end

    it 'routes to #by_summoner' do
      expect(get: '/v1/league_of_legends_profiles/region/summoner_name').to route_to(
        'v1/league_of_legends_profiles#by_summoner',
        region:        'region',
        summoner_name: 'summoner_name'
      )
    end

    it 'routes to #create' do
      expect(post: '/v1/league_of_legends_profiles').to route_to('v1/league_of_legends_profiles#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/v1/league_of_legends_profiles/1').to route_to('v1/league_of_legends_profiles#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/v1/league_of_legends_profiles/1').to route_to('v1/league_of_legends_profiles#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/v1/league_of_legends_profiles/1').to route_to('v1/league_of_legends_profiles#destroy', id: '1')
    end
  end
end
