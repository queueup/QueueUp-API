# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Interaction, type: :model do
  it :has_valid_factory do
    expect(build(:interaction)).to be_valid
  end

  describe 'callbacks' do
    it :worker_creation do
      expect do
        create(:interaction)
      end.to change(InteractionsWorker.jobs, :size).by(1)
    end

    describe 'match_creation' do
      it :both_liked do
        interaction = create(:interaction, liked: true)
        create(:interaction, target: interaction.game_profile, game_profile: interaction.target, liked: true)
        InteractionsWorker.new.perform(interaction.id)
        expect(Match.all.size).to eq(1)
      end

      it :one_liked do
        interaction = create(:interaction, liked: true)
        create(:interaction, target: interaction.game_profile, game_profile: interaction.target, liked: false)
        InteractionsWorker.new.perform(interaction.id)
        expect(Match.all.size).to eq(0)
      end
    end
  end
end
