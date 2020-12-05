# frozen_string_literal: true

FactoryBot.define do
  factory :game_profile_score do
    game_profile { create(:league_of_legends_game_profile) }
    target_game_profile { create(:league_of_legends_game_profile) }
    score
  end
end
