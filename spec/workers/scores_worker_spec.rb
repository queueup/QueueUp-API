# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ScoresWorker, type: :worker do
  it 'enqueues worker' do
    expect do
      create(:game_profile_score)
    end.to change(ScoresWorker.jobs, :size).by(1)
  end

  it 'updates scores' do
    gp = create(:league_of_legends_game_profile)
    expect(gp.scores.keys.size).to eq(0)
    create(:game_profile_score, target_game_profile: gp)
    ScoresWorker.new.perform(gp.id)
    gp.reload
    expect(gp.scores.keys.size).to eq(1)
  end
end
