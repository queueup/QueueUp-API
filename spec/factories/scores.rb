# frozen_string_literal: true

FactoryBot.define do
  factory :score do
    sequence(:key) do |n|
      "#{Faker::Lorem.word} #{n}"
    end
    positive { [true, false].sample }
  end
end
