# frozen_string_literal: true

handles = %w[
  Ninja
  SofianeG
  Teazie
]

FactoryBot.define do
  factory :fortnite_profile do
    sequence(:handle) do |n|
      handles[n % handles.size]
    end
  end
end
