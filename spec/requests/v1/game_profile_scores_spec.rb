# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GameProfileScores', type: :request do
  let(:user) { create(:user) }
  let(:other_device) { create(:device) }
  let(:profile) { create(:league_of_legends_game_profile, user: user) }

  # TODO: Add tests for filters
  describe 'POST /v1/game_profile_scores' do
    describe 'signed in' do
      it 'creates game profile score' do
        post v1_game_profile_scores_path,
             params:  {
               game_profile_score: attributes_for(:game_profile_score,
                                                  game_profile_id:   profile.id,
                                                  target_game_profile_id: create(:league_of_legends_game_profile).id,
                                                  score_id: create(:score).id)
             },
             headers: user.create_new_auth_token
        expect(response).to have_http_status(:created)
      end

      it '!creates game profile score with other profile' do
        post v1_game_profile_scores_path,
             params:  {
               game_profile_score: attributes_for(:game_profile_score,
                                                  game_profile_id:   create(:league_of_legends_game_profile).id,
                                                  target_game_profile_id: create(:league_of_legends_game_profile).id,
                                                  score_id: create(:score).id)
             },
             headers: user.create_new_auth_token
        expect(response).not_to have_http_status(:created)
      end
    end

    describe '!signed in' do
      it '!creates game profile score' do
        post v1_game_profile_scores_path,
             params: {
               game_profile_score: attributes_for(:game_profile_score,
                                                  game_profile_id:   create(:league_of_legends_game_profile).id,
                                                  target_game_profile_id: create(:league_of_legends_game_profile).id,
                                                  score_id: create(:score).id)
             }
        expect(response).not_to have_http_status(:created)
      end
    end
  end
end
