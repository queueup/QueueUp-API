# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Devices', type: :request do
  let(:user) { create(:user) }
  let(:other_device) { create(:device) }

  describe 'POST /v1/devices' do
    describe 'signed in' do
      it 'creates device' do
        post v1_devices_path,
             params:  { device: attributes_for(:device) },
             headers: user.create_new_auth_token
        expect(response).to have_http_status(:created)
        expect(user.devices.size).to eq(1)
      end
    end

    describe '!signed in' do
      it 'creates device' do
        post v1_devices_path,
             params: { device: attributes_for(:device) }
        expect(response).not_to have_http_status(:created)
        expect(Message.all.size).to eq(0)
      end
    end
  end

  describe 'GET /v1/devices/:id' do
    describe 'signed in' do
      it 'returns own device' do
        device = create(:device, user: user)
        get v1_device_path(device), headers: user.create_new_auth_token
        expect(response).to have_http_status(:ok)
      end

      it '!returns other device' do
        get v1_device_path(other_device), headers: user.create_new_auth_token
        expect(response).to have_http_status(:forbidden)
      end

      it '!returns inexistant device' do
        get v1_device_path('inexistant_record'), headers: user.create_new_auth_token
        expect(response).to have_http_status(:not_found)
      end
    end

    describe '!signed in' do
      it '!returns device' do
        get v1_device_path(other_device)
        expect(response).to have_http_status(:unauthorized)
      end

      it '!returns inexistant device' do
        get v1_device_path('inexistant_record')
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
