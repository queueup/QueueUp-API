# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message, type: :model do
  it :has_valid_factory do
    expect(build(:message)).to be_valid
  end

  describe 'validations' do
    describe 'match' do
      it :presence do
        expect(build(:message, match: nil)).not_to be_valid
      end
    end

    describe 'game_profile' do
      it :presence do
        expect(build(:message, match: nil)).not_to be_valid
      end
    end

    describe 'content' do
      it :presence do
        expect(build(:message, content: nil)).not_to be_valid
      end
    end
  end
end
