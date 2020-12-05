# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LeagueOfLegendsPosition, type: :model do
  it :has_valid_factory do
    expect(build(:league_of_legends_position)).to be_valid
  end
end
