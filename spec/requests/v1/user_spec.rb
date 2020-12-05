# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User', type: :request do
  let(:user) { create(:user) }

  describe 'GET /v1/user' do
    describe 'signed in' do
      it 'returns own profile' do
        get '/v1/user', headers: user.create_new_auth_token
        expect(response).to have_http_status(:ok)
      end
    end

    describe '!signed in' do
      it '!returns profile' do
        get '/v1/user'
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PATCH /v1/user' do
    describe 'signed in' do
      it 'updates own profile' do
        new_attributes = { locales: attributes_for(:user)[:locales] }
        patch '/v1/user',
              params:  { user: new_attributes },
              headers: user.create_new_auth_token
        expect(response).to have_http_status(:ok)
        expect(json[:locales]).to eq(new_attributes[:locales])
      end
    end
  end

  describe '!signed in' do
    it '!updates profile' do
      new_attributes = { locales: attributes_for(:user)[:locales] }
      patch '/v1/user',
            params: { user: new_attributes }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
