# frozen_string_literal: true

module FortniteProfileAbility
  def fortnite_profile_ability(user)
    can :manage, FortniteProfile do |profile|
      !profile.game_profile.nil? && profile.game_profile.user == user
    end
  end
end
