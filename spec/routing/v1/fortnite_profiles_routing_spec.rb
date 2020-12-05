# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::FortniteProfilesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/v1/fortnite_profiles').not_to route_to('v1/fortnite_profiles#index')
    end

    it 'routes to #show' do
      expect(get: '/v1/fortnite_profiles/1').to route_to('v1/fortnite_profiles#show', id: '1')
    end

    it 'routes to #by_handle' do
      expect(get: '/v1/fortnite_profiles/1/by_handle').to route_to('v1/fortnite_profiles#by_handle', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/v1/fortnite_profiles').to route_to('v1/fortnite_profiles#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/v1/fortnite_profiles/1').to route_to('v1/fortnite_profiles#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/v1/fortnite_profiles/1').to route_to('v1/fortnite_profiles#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/v1/fortnite_profiles/1').to route_to('v1/fortnite_profiles#destroy', id: '1')
    end
  end
end
