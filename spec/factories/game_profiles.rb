# frozen_string_literal: true

FactoryBot.define do
  factory :game_profile do
    factory :fortnite_game_profile do
      resource { create(:fortnite_profile) }
    end

    factory :league_of_legends_game_profile do
      resource { create(:league_of_legends_profile) }
    end

    user
  end
end
