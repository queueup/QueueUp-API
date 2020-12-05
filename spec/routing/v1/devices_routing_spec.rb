# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::DevicesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/v1/devices').to route_to('v1/devices#index')
    end

    it 'routes to #show' do
      expect(get: '/v1/devices/1').to route_to('v1/devices#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/v1/devices').to route_to('v1/devices#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/v1/devices/1').not_to route_to('v1/devices#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/v1/devices/1').not_to route_to('v1/devices#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/v1/devices/1').to route_to('v1/devices#destroy', id: '1')
    end
  end
end
