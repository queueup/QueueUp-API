# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Messages', type: :request do
  let(:user) { create(:user) }
  let(:own_profile) { create(:league_of_legends_game_profile, user: user) }
  let(:other_profile) { create(:league_of_legends_game_profile) }
  let(:other_message) { create(:message) }

  describe 'POST /v1/messages' do
    describe 'signed in' do
      it 'creates message' do
        post v1_messages_path,
             params:  { message: attributes_for(:message,
                                                match_id:        create(:match_membership,
                                                                        game_profile: own_profile).match_id,
                                                game_profile_id: own_profile.id) },
             headers: user.create_new_auth_token
        expect(response).to have_http_status(:created)
        expect(user.messages.size).to eq(1)
      end
    end

    describe '!signed in' do
      it 'creates message' do
        post v1_messages_path,
             params: { message: attributes_for(:message, match_id: create(:match_membership,
                                                                          game_profile: own_profile).match_id) }
        expect(response).not_to have_http_status(:created)
        expect(Message.all.size).to eq(0)
      end
    end
  end

  describe 'GET /v1/messages/:id' do
    describe 'signed in' do
      it 'returns own message' do
        match = create(:message, match: create(:match_membership, game_profile: own_profile).match)
        get v1_message_path(match), headers: user.create_new_auth_token
        expect(response).to have_http_status(:ok)
      end

      it '!returns other message' do
        get v1_message_path(other_message), headers: user.create_new_auth_token
        expect(response).to have_http_status(:forbidden)
      end

      it '!returns inexistant message' do
        get v1_message_path('inexistant_record'), headers: user.create_new_auth_token
        expect(response).to have_http_status(:not_found)
      end
    end

    describe '!signed in' do
      it '!returns message' do
        get v1_message_path(other_message)
        expect(response).to have_http_status(:unauthorized)
      end

      it '!returns inexistant message' do
        get v1_message_path('inexistant_record')
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
