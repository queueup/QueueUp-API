# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GameProfileReport, type: :model do
  it :has_valid_factory do
    expect(build(:game_profile_report)).to be_valid
  end

  describe 'validations' do
    describe 'reason' do
      it :presence do
        expect(build(:game_profile_report, reason: nil)).not_to be_valid
      end
    end

    describe 'game_profile' do
      it :presence do
        expect(build(:game_profile_report, game_profile: nil)).not_to be_valid
      end
    end

    describe 'target_profile' do
      it :presence do
        expect(build(:game_profile_report, target_profile: nil)).not_to be_valid
      end

      it :uniqueness do
        report = create(:game_profile_report)
        expect(
          build(:game_profile_report, game_profile: report.game_profile, target_profile: report.target_profile)
        ).not_to be_valid
      end
    end
  end
end
