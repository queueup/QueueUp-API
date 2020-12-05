# frozen_string_literal: true

summoner_names = %w[
  Teazie
  Sarcastique
  Rekkles
  Andoslash
  Zerp357
  remi5151
]

FactoryBot.define do
  factory :league_of_legends_profile do
    sequence(:summoner_name) do |n|
      summoner_names[n % summoner_names.size]
    end
    region 'euw'
  end
end
