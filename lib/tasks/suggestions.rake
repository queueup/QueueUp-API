# frozen_string_literal: true

namespace :suggestions do
  desc 'Reload all League of Legends profiles'
  task check: :environment do
    GameProfile.where('cleared_suggestions_at IS NOT NULL').each do |game_profile|
      if GameProfile.eligible_for(game_profile).size >= 10
        SuggestionsNotificationWorker.perform_async(game_profile.id)
        game_profile.update(cleared_suggestions_at: nil)
      end
    end
  end
end
