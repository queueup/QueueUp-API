# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GameProfiles', type: :request do
  let(:user) { create(:user) }

  describe 'GET /v1_game_profiles' do
    describe 'signed in' do
      it 'returns own game profiles' do
        create(:league_of_legends_game_profile, user: user)
        get v1_game_profiles_path, headers: user.create_new_auth_token
        expect(response).to have_http_status(:ok)
        expect(json.length).to eq(1)
      end

      it '!returns other game profiles' do
        create(:league_of_legends_game_profile)
        get v1_game_profiles_path, headers: user.create_new_auth_token
        expect(response).to have_http_status(:ok)
        expect(json.length).to eq(0)
      end
    end

    describe '!signed in' do
      it 'returns game profiles' do
        create(:league_of_legends_game_profile, user: user)
        get v1_game_profiles_path
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
