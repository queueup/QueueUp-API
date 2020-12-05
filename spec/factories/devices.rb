# frozen_string_literal: true

FactoryBot.define do
  factory :device do
    player_id { SecureRandom.uuid }
    user
  end
end
