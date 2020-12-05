# frozen_string_literal: true

module MatchAbility
  def match_ability(user)
    can :manage, Match do |match|
      match.users.include?(user)
    end
  end
end
