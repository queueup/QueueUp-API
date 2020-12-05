# frozen_string_literal: true

module LeagueOfLegendsProfileAbility
  def league_of_legends_profile_ability(user)
    can :manage, LeagueOfLegendsProfile do |profile|
      !profile.game_profile.nil? && profile.game_profile.user == user
    end
  end
end
