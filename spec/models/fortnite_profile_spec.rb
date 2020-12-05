# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FortniteProfile, type: :model do
  it :has_valid_factory do
    expect(build(:fortnite_profile)).to be_valid
  end

  describe 'validations' do
    describe 'summoner' do
      it :uniqueness do
        profile = create(:fortnite_profile)
        expect(build(:fortnite_profile, handle: profile.handle)).not_to be_valid
      end
    end
  end
end
