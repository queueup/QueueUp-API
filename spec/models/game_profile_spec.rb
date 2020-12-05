# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GameProfile, type: :model do
  it :has_valid_factories do
    expect(build(:league_of_legends_game_profile)).to be_valid
  end
end
