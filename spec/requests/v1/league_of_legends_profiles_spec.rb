# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'LeagueOfLegendsProfiles', type: :request do
  let(:user) { create(:user) }
  let(:own_profile) do
    profile = create(:league_of_legends_profile)
    create(:league_of_legends_game_profile, resource: profile, user: user)
    return profile
  end
  let(:other_profile) { create(:league_of_legends_profile) }

  describe 'POST /v1/league_of_legends_profiles' do
    describe 'signed in' do
      it 'creates league profile' do
        post v1_league_of_legends_profiles_path,
             params:  { league_of_legends_profile: attributes_for(:league_of_legends_profile) },
             headers: user.create_new_auth_token
        expect(response).to have_http_status(:created)
        expect(user.game_profiles.size).to eq(1)
      end

      it 'links existing league profile' do
        league_profile_attributes = attributes_for(:league_of_legends_profile)
        LeagueOfLegendsProfile.create(league_profile_attributes)
        expect(user.game_profiles.size).to eq(0)
        post v1_league_of_legends_profiles_path,
             params:  { league_of_legends_profile: attributes_for(:league_of_legends_profile) },
             headers: user.create_new_auth_token
        expect(response).to have_http_status(:created)
        user.reload
        expect(user.game_profiles.size).to eq(1)
      end
    end

    describe '!signed in' do
      it 'creates league profile' do
        post v1_league_of_legends_profiles_path,
             params: { league_of_legends_profile: attributes_for(:league_of_legends_profile) }
        expect(response).to have_http_status(:created)
        expect(GameProfile.all.size).to eq(0)
      end
    end
  end

  describe 'GET /v1/league_of_legends_profiles/:id' do
    describe 'signed in' do
      it 'returns own league profile' do
        get v1_league_of_legends_profile_path(own_profile), headers: user.create_new_auth_token
        expect(response).to have_http_status(:ok)
      end

      it '!returns other league profile' do
        get v1_league_of_legends_profile_path(other_profile), headers: user.create_new_auth_token
        expect(response).to have_http_status(:forbidden)
      end

      it '!returns inexistant league profile' do
        get v1_league_of_legends_profile_path('inexistant_record'), headers: user.create_new_auth_token
        expect(response).to have_http_status(:not_found)
      end
    end

    describe '!signed in' do
      it '!returns league profile' do
        get v1_league_of_legends_profile_path(other_profile)
        expect(response).to have_http_status(:unauthorized)
      end

      it '!returns inexistant league profile' do
        get v1_league_of_legends_profile_path('inexistant_record')
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /v1/league_of_legends_profiles/:region/:summoner_name' do
    it 'returns league profile' do
      get "/v1/league_of_legends_profiles/#{other_profile.region}/#{other_profile.summoner_name}"
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH /v1/league_of_legends_profiles/:id' do
    describe 'signed in' do
      it 'updates own league profile' do
        new_attributes = { champions: %w[1 2 3 4] }
        patch v1_league_of_legends_profile_path(own_profile),
              params:  { league_of_legends_profile: new_attributes },
              headers: user.create_new_auth_token
        expect(response).to have_http_status(:ok)
        expect(json[:champions]).to eq(new_attributes[:champions])
      end

      it '!updates other league profile' do
        new_attributes = { champions: %w[1 2 3 4] }
        patch v1_league_of_legends_profile_path(other_profile),
              params:  { league_of_legends_profile: new_attributes },
              headers: user.create_new_auth_token
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe '!signed in' do
      it '!updates league profile' do
        new_attributes = { champions: %w[1 2 3 4] }
        patch v1_league_of_legends_profile_path(other_profile),
              params: { league_of_legends_profile: new_attributes }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PATCH /v1/league_of_legends_profiles/:id/reload' do
    describe 'signed in' do
      it 'updates own league profile' do
        patch reload_v1_league_of_legends_profile_path(own_profile),
              headers: user.create_new_auth_token
        expect(response).to have_http_status(:ok)
      end

      it '!updates other league profile' do
        patch reload_v1_league_of_legends_profile_path(other_profile),
              headers: user.create_new_auth_token
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe '!signed in' do
      it '!updates league profile' do
        patch reload_v1_league_of_legends_profile_path(other_profile)
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /v1/league_of_legends_profiles/:id' do
    describe 'signed in' do
      it 'unlinks own league profile' do
        delete v1_league_of_legends_profile_path(own_profile),
               headers: user.create_new_auth_token
        expect(response).to have_http_status(:no_content)
        expect(user.game_profiles.size).to eq(0)
      end

      it '!unlinks other league profile' do
        delete v1_league_of_legends_profile_path(other_profile),
               headers: user.create_new_auth_token
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe '!signed in' do
    it '!unlinks league profile' do
      delete v1_league_of_legends_profile_path(other_profile)
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
