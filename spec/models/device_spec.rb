# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Device, type: :model do
  it :has_valid_factory do
    expect(build(:device)).to be_valid
  end

  describe 'validations' do
    describe 'player_id' do
      it :presence do
        expect(build(:device, player_id: nil)).not_to be_valid
      end

      it :uniqueness do
        device = create(:device)
        expect(build(:device, player_id: device.player_id)).not_to be_valid
      end
    end
  end
end
