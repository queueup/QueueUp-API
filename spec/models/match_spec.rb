# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Match, type: :model do
  it :has_valid_factory do
    expect(build(:match)).to be_valid
  end

  describe 'validations' do
    it :match_memberships do
      profile1 = create(:league_of_legends_game_profile)
      profile2 = create(:league_of_legends_game_profile)
      create(:match, match_memberships: [
               create(:match_membership, game_profile: profile1),
               create(:match_membership, game_profile: profile2)
             ])
    end
  end

  describe 'from_game_profiles' do
    it :finds_match do
      profile1 = create(:league_of_legends_game_profile)
      profile2 = create(:league_of_legends_game_profile)
      match = create(:match, match_memberships: [
                       create(:match_membership, game_profile: profile1),
                       create(:match_membership, game_profile: profile2)
                     ])
      expect(Match.from_game_profiles([profile1.id, profile2.id]).id).to eq(match.id)
    end
  end

  describe 'last_message' do
    it :returns_last_message do
      mm = create(:match_membership)
      match = mm.match
      game_profile = mm.game_profile

      message1 = create(:message, match: match, game_profile: game_profile)
      expect(match.last_message.id).to eq(message1.id)
      message2 = create(:message, match: match, game_profile: game_profile)
      match.reload
      expect(match.last_message.id).to eq(message2.id)
      mm2 = create(:match_membership, match: match)
      game_profile2 = mm2.game_profile
      message3 = create(:message, match: match, game_profile: game_profile2)
      match.reload
      expect(match.last_message.id).to eq(message3.id)
      message4 = create(:message, match: match, game_profile: game_profile2)
      match.reload
      expect(match.last_message.id).to eq(message4.id)
    end
  end
end
