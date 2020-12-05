# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::GameProfileScoresController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/v1/game_profile_scores').to route_to('v1/game_profile_scores#index')
    end

    it 'routes to #show' do
      expect(get: '/v1/game_profile_scores/1').to route_to('v1/game_profile_scores#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/v1/game_profile_scores').to route_to('v1/game_profile_scores#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/v1/game_profile_scores/1').to route_to('v1/game_profile_scores#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/v1/game_profile_scores/1').to route_to('v1/game_profile_scores#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/v1/game_profile_scores/1').to route_to('v1/game_profile_scores#destroy', id: '1')
    end
  end
end
