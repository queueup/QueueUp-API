# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::UsersController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/v1/user').to route_to('v1/users#show')
    end

    it 'routes to #update via PUT' do
      expect(put: '/v1/user').to route_to('v1/users#update')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/v1/user').to route_to('v1/users#update')
    end
  end
end
