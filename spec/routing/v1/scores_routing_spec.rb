# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::ScoresController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/v1/scores').to route_to('v1/scores#index')
    end

    it 'routes to #show' do
      expect(get: '/v1/scores/1').to route_to('v1/scores#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/v1/scores').not_to route_to('v1/scores#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/v1/scores/1').not_to route_to('v1/scores#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/v1/scores/1').not_to route_to('v1/scores#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/v1/scores/1').not_to route_to('v1/scores#destroy', id: '1')
    end
  end
end
