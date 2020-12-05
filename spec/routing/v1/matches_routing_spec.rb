# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::MatchesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/v1/matches').to route_to('v1/matches#index')
    end

    it 'routes to #show' do
      expect(get: '/v1/matches/1').to route_to('v1/matches#show', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/v1/matches/1').to route_to('v1/matches#destroy', id: '1')
    end
  end
end
