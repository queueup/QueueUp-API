# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GameProfileScore, type: :model do
  it :has_valid_factory do
    expect(build(:game_profile_score)).to be_valid
  end

  describe 'validations' do
    describe 'game_profile' do
      it :presence do
        expect(build(:game_profile_score, game_profile: nil)).not_to be_valid
      end
    end

    describe 'target_game_profile' do
      it :presence do
        expect(build(:game_profile_score, target_game_profile: nil)).not_to be_valid
      end

      it :uniqueness do
        report = create(:game_profile_score)
        expect(
          build(:game_profile_score, game_profile: report.game_profile, target_game_profile: report.target_game_profile)
        ).not_to be_valid
      end
    end
  end
end
