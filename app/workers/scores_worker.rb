# frozen_string_literal: true

class ScoresWorker
  include Sidekiq::Worker

  def perform(game_profile_id)
    game_profile = GameProfile.find(game_profile_id)

    return if game_profile.nil?

    game_profile.scores = game_profile.received_game_profile_scores.joins(:score).group('scores.key').count
    game_profile.save!
  end
end
