# frozen_string_literal: true

class LeagueOfLegendsMatch < ApplicationRecord
  belongs_to :league_of_legends_profile
  has_one :game_profile, through: :league_of_legends_profile
end
