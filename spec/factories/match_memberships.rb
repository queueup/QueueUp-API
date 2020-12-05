# frozen_string_literal: true

FactoryBot.define do
  factory :match_membership do
    game_profile { create(:league_of_legends_game_profile) }
    match
  end
end
