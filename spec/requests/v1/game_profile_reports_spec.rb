# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GameProfileReports', type: :request do
  let(:user) { create(:user) }
  let(:other_device) { create(:device) }
  let(:profile) { create(:league_of_legends_game_profile, user: user) }

  describe 'POST /v1/game_profile_reports' do
    describe 'signed in' do
      it 'creates game profile report' do
        post v1_game_profile_reports_path,
             params:  {
               game_profile_report: attributes_for(:game_profile_report,
                                                   game_profile_id:   profile.id,
                                                   target_profile_id: create(:league_of_legends_game_profile).id)
             },
             headers: user.create_new_auth_token
        expect(response).to have_http_status(:created)
      end

      it '!creates game profile report with other profile' do
        post v1_game_profile_reports_path,
             params:  {
               game_profile_report: attributes_for(:game_profile_report,
                                                   game_profile_id:   create(:league_of_legends_game_profile).id,
                                                   target_profile_id: create(:league_of_legends_game_profile).id)
             },
             headers: user.create_new_auth_token
        expect(response).not_to have_http_status(:created)
      end
    end

    describe '!signed in' do
      it '!creates game profile report' do
        post v1_game_profile_reports_path,
             params: {
               game_profile_report: attributes_for(:game_profile_report,
                                                   game_profile_id:   create(:league_of_legends_game_profile).id,
                                                   target_profile_id: create(:league_of_legends_game_profile).id)
             }
        expect(response).not_to have_http_status(:created)
      end
    end
  end
end
