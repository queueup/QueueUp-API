# frozen_string_literal: true

ForestLiana.env_secret = ENV['FOREST_ENV_SECRET']
ForestLiana.auth_secret = ENV['FOREST_AUTH_SECRET']

ForestLiana.included_models = %w[
  Device
  FortniteProfile
  GameProfileReport
  GameProfileScore
  Interaction
  LeagueOfLegendsMatch
  LeagueOfLegendsPosition
  LeagueOfLegendsProfile
  MatchMembership
  Match
  Message
  Score
  User
]
