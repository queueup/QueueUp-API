# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Score, type: :model do
  it :has_valid_factory do
    expect(build(:score)).to be_valid
  end

  describe 'validations' do
    describe 'key' do
      it :presence do
        expect(build(:score, key: nil)).not_to be_valid
      end

      it :uniqueness do
        score = create(:score)
        expect(build(:score, key: score.key)).not_to be_valid
      end
    end

    describe 'positive' do
      it :presence do
        expect(build(:score, positive: nil)).not_to be_valid
      end
    end
  end
end
