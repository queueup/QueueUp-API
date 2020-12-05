# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Scores', type: :request do
  describe 'GET /v1/scores' do
    it 'returns list of scores' do
      Score.destroy_all
      create(:score)
      get v1_scores_path
      expect(response).to have_http_status(:ok)
      expect(json.size).to eq(1)
    end
  end

  describe 'GET /v1/scores/:id' do
    it 'returns score' do
      score = create(:score)
      get v1_score_path(score)
      expect(response).to have_http_status(:ok)
    end
  end
end
