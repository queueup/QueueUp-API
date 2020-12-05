# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Badges', type: :request do
  describe 'GET /v1/badges' do
    it 'returns badges' do
      get v1_badges_path
      expect(response).to have_http_status(:ok)
      expect(json.size).to eq(Merit::Badge.count)
    end
  end
end
