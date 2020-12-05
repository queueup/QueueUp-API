# frozen_string_literal: true

class InteractionsWorker
  include Sidekiq::Worker

  def perform(interaction_id)
    interaction = Interaction.find(interaction_id)

    return unless interaction.liked

    return unless Interaction.exists?(game_profile: interaction.target, liked: true, target: interaction.game_profile)

    Match.create!(match_memberships: [
                    MatchMembership.new(game_profile_id: interaction.game_profile_id),
                    MatchMembership.new(game_profile_id: interaction.target_id)
                  ])
  end
end
