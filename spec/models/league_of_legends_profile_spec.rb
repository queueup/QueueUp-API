# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LeagueOfLegendsProfile, type: :model do
  it :has_valid_factory do
    expect(build(:league_of_legends_profile)).to be_valid
  end

  describe 'validations' do
    describe 'summoner' do
      it :uniqueness do
        profile = create(:league_of_legends_profile)
        expect(build(:league_of_legends_profile,
                     summoner_name: profile.summoner_name,
                     region:        profile.region)).not_to be_valid
      end
    end

    describe 'region' do
      it :presence do
        expect(build(:league_of_legends_profile, region: nil)).not_to be_valid
      end
    end

    describe 'summoner_name' do
      it :presence do
        expect(build(:league_of_legends_profile, summoner_name: nil)).not_to be_valid
      end
    end
  end
end
