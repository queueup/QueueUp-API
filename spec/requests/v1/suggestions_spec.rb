# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Suggestions', type: :request do
  let(:user) { create(:user) }

  describe 'GET /v1/suggestions' do
    describe 'signed in' do
      it 'returns league of legends suggestions' do
        game_profile = create(:league_of_legends_game_profile, user: user)
        # This one is from the same user
        create(:league_of_legends_game_profile, user: user)
        # This one has already an interaction
        create(:interaction, game_profile: game_profile, target_id: create(:league_of_legends_game_profile).id)
        # This one is from another region
        create(:league_of_legends_game_profile,
               resource: create(:league_of_legends_profile, region: 'NA', summoner_name: 'Sneaky'))
        # This one should be accepted
        accepted_gp = create(:league_of_legends_game_profile)
        get v1_suggestions_path,
            params:  { game_profile_id: game_profile.id },
            headers: user.create_new_auth_token
        expect(response).to have_http_status(:ok)
        expect(json.length).to eq(1)
        expect(json.first[:id]).to eq(accepted_gp.id)
      end
    end
  end

  describe 'GET /v1/suggestionsOrdered' do
    describe 'signed in' do
      it 'returns league of legends suggestions' do
        game_profile = create(:league_of_legends_game_profile, user: user)
        # We create three game_profile to check if the order by connected_at is working
        create(:league_of_legends_game_profile, connected_at: Time.zone.now - 5.days)
        g2 = create(:league_of_legends_game_profile, connected_at: Time.zone.now - 2.days)
        create(:league_of_legends_game_profile, connected_at: Time.zone.now - 7.days)
        get v1_suggestions_path,
            params:  { game_profile_id: game_profile.id },
            headers: user.create_new_auth_token
        expect(response).to have_http_status(:ok)
        expect(json.length).to eq(3)
        expect(json.first[:id]).to eq(g2.id)
      end
    end
  end
end
