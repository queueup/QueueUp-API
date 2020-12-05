# frozen_string_literal: true

namespace :fortnite do
  desc 'Reload all Fortnite profiles'
  task reload_all: :environment do
    FortniteProfile.all.map(&:force_update)
  end
end
