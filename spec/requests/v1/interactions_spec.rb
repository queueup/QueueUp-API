# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Interactions', type: :request do
  let(:user) { create(:user) }
  let(:game_profile) { create(:league_of_legends_game_profile, user: user) }
  let(:valid_attributes) do
    {
      game_profile_id: game_profile.id,
      target_id:       create(:league_of_legends_game_profile).id,
      liked:           true
    }
  end

  describe 'POST /v1/interactions' do
    describe 'signed in' do
      it 'creates own interaction' do
        post v1_interactions_path,
             params:  { interaction: valid_attributes },
             headers: user.create_new_auth_token
        expect(response).to have_http_status(:created)
      end

      it '!creates others interaction' do
        attributes = valid_attributes
        attributes[:game_profile_id] = create(:league_of_legends_game_profile).id
        post v1_interactions_path,
             params:  { interaction: attributes },
             headers: user.create_new_auth_token
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe '!signed in' do
      it '!creates interaction' do
        post v1_interactions_path,
             params: { interaction: valid_attributes }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
