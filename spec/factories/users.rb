# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    locales { %w[fr-FR fr-CA en-GB en-US].sample(rand(1..3)) }
  end
end
