# frozen_string_literal: true

class Score < ApplicationRecord
  has_many :game_profile_scores, dependent: :destroy
  has_many :game_profiles, through: :game_profile_scores

  validates :key, presence: true, uniqueness: true
  validates :positive, inclusion: { in: [true, false] }
end
