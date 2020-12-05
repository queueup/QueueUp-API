# frozen_string_literal: true

namespace :league_of_legends do
  desc 'Reload all League of Legends profiles'
  task reload_all: :environment do
    LeagueOfLegendsProfile.all.map(&:force_update)
  end
end
