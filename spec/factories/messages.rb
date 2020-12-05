# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    content { Faker::LeagueOfLegends.quote }
    game_profile { create(:league_of_legends_game_profile) }
    match
  end
end
