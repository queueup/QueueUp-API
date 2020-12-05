# frozen_string_literal: true

FactoryBot.define do
  factory :game_profile_report do
    game_profile { create(:league_of_legends_game_profile) }
    target_profile { create(:league_of_legends_game_profile) }
    reason { GameProfileReport.reasons.keys.sample }
    description { Faker::Lorem.sentence }
  end
end
