# frozen_string_literal: true

FORTNITE_AVATARS = (0..553).map { |nb| "#{nb}.png" }
                           .sort { |a, b| a.split('.').first.to_i <=> b.split('.').first.to_i }
