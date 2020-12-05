# frozen_string_literal: true

FactoryBot.define do
  factory :interaction do
    game_profile { create(:league_of_legends_game_profile) }
    target { create(:league_of_legends_game_profile) }
    liked { [true, false].sample }
  end
end
