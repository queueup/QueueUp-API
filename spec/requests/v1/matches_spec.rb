# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Matches', type: :request do
  let(:user) { create(:user) }
  let(:own_profile) { create(:league_of_legends_game_profile, user: user) }

  describe 'GET /v1/matches' do
    describe 'signed in' do
      it 'lists own matches' do
        create(:match_membership, game_profile: own_profile)
        get v1_matches_path, headers: user.create_new_auth_token
        expect(response).to have_http_status(:ok)
        expect(json.length).to eq(1)
      end

      it '!lists others matches' do
        create(:match)
        get v1_matches_path, headers: user.create_new_auth_token
        expect(response).to have_http_status(:ok)
        expect(json.length).to eq(0)
      end

      it '!lists canceled matches' do
        create(:match_membership, game_profile: own_profile, match: create(:match, canceled_at: Time.zone.now))
        get v1_matches_path, headers: user.create_new_auth_token
        expect(response).to have_http_status(:ok)
        expect(json.length).to eq(0)
      end
    end

    describe '!signed in' do
      it '!lists matches' do
        create(:match)
        get v1_matches_path
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /v1/matches/:id' do
    describe 'signed in' do
      it 'shows own match' do
        match = create(:match, game_profile_ids: [own_profile.id, create(:league_of_legends_game_profile).id])
        get v1_match_path(match), headers: user.create_new_auth_token
        expect(response).to have_http_status(:ok)
      end

      it '!shows others matches' do
        match = create(:match)
        get v1_match_path(match), headers: user.create_new_auth_token
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe '!signed in' do
      it '!shows matches' do
        match = create(:match)
        get v1_match_path(match)
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
