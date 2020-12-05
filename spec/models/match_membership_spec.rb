# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MatchMembership, type: :model do
  it :has_valid_factory do
    expect(build(:match_membership)).to be_valid
  end

  describe 'validations' do
    describe 'match' do
      it :presence do
        expect(build(:match_membership, match: nil)).not_to be_valid
      end

      it :uniqueness do
        mm = create(:match_membership)
        expect(build(:match_membership, match: mm.match, game_profile: mm.game_profile)).not_to be_valid
      end
    end

    describe 'game_profile' do
      it :presence do
        expect(build(:match_membership, game_profile: nil)).not_to be_valid
      end
    end
  end
end
