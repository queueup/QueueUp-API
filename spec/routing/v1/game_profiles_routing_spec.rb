# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::GameProfilesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/v1/game_profiles').to route_to('v1/game_profiles#index')
    end

    it 'routes to #show' do
      expect(get: '/v1/game_profiles/1').to route_to('v1/game_profiles#show', id: '1')
    end
  end
end
