# frozen_string_literal: true

FactoryBot.define do
  factory :league_of_legends_position do
    league_of_legends_profile
    rank 'MyString'
    queue_type 'MyString'
    hot_streak false
    wins 1
    veteran false
    losses 1
    fresh_blood false
    league_id 'MyString'
    player_or_team_name 'MyString'
    inactive false
    player_or_team_id 'MyString'
    league_name 'MyString'
    tier 'MyString'
    league_points 1
  end
end
