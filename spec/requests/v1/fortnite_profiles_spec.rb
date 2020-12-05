# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'FortniteProfiles', type: :request do
  let(:user) { create(:user) }
  let(:own_profile) do
    profile = create(:fortnite_profile)
    create(:fortnite_game_profile, resource: profile, user: user)
    return profile
  end
  let(:other_profile) { create(:fortnite_profile) }

  describe 'POST /v1/fortnite_profiles' do
    describe 'signed in' do
      it 'creates Fortnite profile' do
        post v1_fortnite_profiles_path,
             params:  { fortnite_profile: attributes_for(:fortnite_profile) },
             headers: user.create_new_auth_token
        expect(response).to have_http_status(:created)
        expect(user.game_profiles.size).to eq(1)
      end

      it 'links existing Fortnite profile' do
        league_profile_attributes = attributes_for(:fortnite_profile)
        FortniteProfile.create(league_profile_attributes)
        expect(user.game_profiles.size).to eq(0)
        post v1_fortnite_profiles_path,
             params:  { fortnite_profile: attributes_for(:fortnite_profile) },
             headers: user.create_new_auth_token
        expect(response).to have_http_status(:created)
        user.reload
        expect(user.game_profiles.size).to eq(1)
      end
    end

    describe '!signed in' do
      it 'creates Fortnite profile' do
        post v1_fortnite_profiles_path,
             params: { fortnite_profile: attributes_for(:fortnite_profile) }
        expect(response).to have_http_status(:created)
        expect(GameProfile.all.size).to eq(0)
      end
    end
  end

  describe 'GET /v1/fortnite_profiles/:id' do
    describe 'signed in' do
      it 'returns own Fortnite profile' do
        get v1_fortnite_profile_path(own_profile), headers: user.create_new_auth_token
        expect(response).to have_http_status(:ok)
      end

      it '!returns other Fortnite profile' do
        get v1_fortnite_profile_path(other_profile), headers: user.create_new_auth_token
        expect(response).to have_http_status(:forbidden)
      end

      it '!returns inexistant Fortnite profile' do
        get v1_fortnite_profile_path('inexistant_record'), headers: user.create_new_auth_token
        expect(response).to have_http_status(:not_found)
      end
    end

    describe '!signed in' do
      it '!returns Fortnite profile' do
        get v1_fortnite_profile_path(other_profile)
        expect(response).to have_http_status(:unauthorized)
      end

      it '!returns inexistant Fortnite profile' do
        get v1_fortnite_profile_path('inexistant_record')
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /v1/fortnite_profiles/:handle/by_handle' do
    it 'returns Fortnite profile' do
      get "/v1/fortnite_profiles/#{other_profile.handle}/by_handle"
      expect(response).to have_http_status(:created)
    end
  end

  describe 'PATCH /v1/fortnite_profiles/:id' do
    describe 'signed in' do
      it 'updates own Fortnite profile' do
        new_attributes = { fun: true }
        patch v1_fortnite_profile_path(own_profile),
              params:  { fortnite_profile: new_attributes },
              headers: user.create_new_auth_token
        expect(response).to have_http_status(:ok)
        expect(json[:fun]).to eq(new_attributes[:fun])
      end

      it '!updates other Fortnite profile' do
        new_attributes = { fun: true }
        patch v1_fortnite_profile_path(other_profile),
              params:  { fortnite_profile: new_attributes },
              headers: user.create_new_auth_token
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe '!signed in' do
      it '!updates Fortnite profile' do
        new_attributes = { fun: true }
        patch v1_fortnite_profile_path(other_profile),
              params: { fortnite_profile: new_attributes }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PATCH /v1/fortnite_profiles/:id/reload' do
    describe 'signed in' do
      it 'updates own Fortnite profile' do
        patch reload_v1_fortnite_profile_path(own_profile),
              headers: user.create_new_auth_token
        expect(response).to have_http_status(:ok)
      end

      it '!updates other Fortnite profile' do
        patch reload_v1_fortnite_profile_path(other_profile),
              headers: user.create_new_auth_token
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe '!signed in' do
      it '!updates Fortnite profile' do
        patch reload_v1_fortnite_profile_path(other_profile)
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /v1/fortnite_profiles/:id' do
    describe 'signed in' do
      it 'unlinks own Fortnite profile' do
        delete v1_fortnite_profile_path(own_profile),
               headers: user.create_new_auth_token
        expect(response).to have_http_status(:no_content)
        expect(user.game_profiles.size).to eq(0)
      end

      it '!unlinks other Fortnite profile' do
        delete v1_fortnite_profile_path(other_profile),
               headers: user.create_new_auth_token
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe '!signed in' do
    it '!unlinks Fortnite profile' do
      delete v1_fortnite_profile_path(other_profile)
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
