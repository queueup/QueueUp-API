# frozen_string_literal: true

module MessageAbility
  def message_ability(user)
    can :manage, Message do |message|
      message&.match&.users&.include?(user)
    end
  end
end
