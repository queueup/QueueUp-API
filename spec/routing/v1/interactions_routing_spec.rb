# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::InteractionsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/v1/interactions').to route_to('v1/interactions#create')
    end
  end
end
