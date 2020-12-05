# frozen_string_literal: true

module InteractionAbility
  def interaction_ability(user)
    can :manage, Interaction do |interaction|
      interaction.user == user
    end
  end
end
