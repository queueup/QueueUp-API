# frozen_string_literal: true

module GameProfileAbility
  def game_profile_ability(user)
    can :manage, GameProfile, user_id: user.id
  end
end
