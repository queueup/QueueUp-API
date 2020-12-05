# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize

module Merit
  class BadgeRules
    include Merit::BadgeRulesMethods

    def initialize
      # Explorer => swiped 100 profiles
      grant_on 'interactions#create', badge: 'explorer', to: :user do |interaction|
        interaction.user.interactions.where(liked: true).size > 100
      end

      # Gold digger => swiped 200 profiles
      grant_on 'interactions#create', badge: 'gold-digger', to: :user do |interaction|
        interaction.user.interactions.where(liked: true).size > 200
      end

      # Diamond searcher => swiped 500 profiles
      grant_on 'interactions#create', badge: 'diamond-searcher', to: :user do |interaction|
        interaction.user.interactions.where(liked: true).size > 500
      end

      # Diamond searcher => swiped 500 profiles
      grant_on 'interactions#create', badge: 'swiped-em-all', to: :user, temporary: true do |interaction|
        interaction.game_profile.interactions.size >= GameProfile.eligible_for(interaction.game_profile).size
      end

      # Popular Mate => has 10 matches
      grant_on 'match_memberships#create', badge: 'popular-mate', to: :user do |mm|
        mm.user.matches.size >= 10
      end

      # Famous Mate => has 50 matches
      grant_on 'match_memberships#create', badge: 'famous-mate', to: :user do |mm|
        mm.user.matches.size >= 50
      end

      # The mentor => has 10 matches with n00bs
      grant_on 'match_memberships#create', badge: 'the-mentor', to: :user do |mm|
        mm.user.matched_profiles.where(noob: true).size >= 10
      end
    end
  end
end
# rubocop:enable Metrics/AbcSize
