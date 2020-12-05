# frozen_string_literal: true

class Ability
  include CanCan::Ability

  include DeviceAbility
  include FortniteProfileAbility
  include GameProfileAbility
  include GameProfileReportAbility
  include GameProfileScoreAbility
  include InteractionAbility
  include LeagueOfLegendsProfileAbility
  include MatchAbility
  include MessageAbility

  def initialize(user)
    user ||= User.new

    device_ability user
    fortnite_profile_ability user
    game_profile_ability user
    game_profile_report_ability user
    game_profile_score_ability user
    interaction_ability user
    league_of_legends_profile_ability user
    match_ability user
    message_ability user
  end
end
