# frozen_string_literal: true

module GameProfileScoreAbility
  def game_profile_score_ability(user)
    can :manage, GameProfileScore do |score|
      !score.game_profile.nil? && score.game_profile.user == user
    end
  end
end
