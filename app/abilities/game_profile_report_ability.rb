# frozen_string_literal: true

module GameProfileReportAbility
  def game_profile_report_ability(user)
    can :manage, GameProfileReport do |report|
      !report.game_profile.nil? && report.game_profile.user == user
    end
  end
end
