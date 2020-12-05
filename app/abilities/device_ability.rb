# frozen_string_literal: true

module DeviceAbility
  def device_ability(user)
    can :manage, Device, user_id: user.id
  end
end
