# frozen_string_literal: true

class GameProfileScore < ApplicationRecord
  after_commit :start_worker

  belongs_to :game_profile, optional: false
  belongs_to :target_game_profile, class_name: 'GameProfile', inverse_of: :received_game_profile_scores, optional: false
  belongs_to :score, optional: false

  validates :game_profile, uniqueness: { scope: :target_game_profile }

  protected

  def start_worker
    ScoresWorker.perform_async(target_game_profile_id)
  end
end
