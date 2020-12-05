# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::GameProfileReportsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/v1/game_profile_reports').not_to route_to('v1/game_profile_reports#index')
    end

    it 'routes to #show' do
      expect(get: '/v1/game_profile_reports/1').not_to route_to('v1/game_profile_reports#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/v1/game_profile_reports').to route_to('v1/game_profile_reports#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/v1/game_profile_reports/1').not_to route_to('v1/game_profile_reports#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/v1/game_profile_reports/1').not_to route_to('v1/game_profile_reports#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/v1/game_profile_reports/1').not_to route_to('v1/game_profile_reports#destroy', id: '1')
    end
  end
end
