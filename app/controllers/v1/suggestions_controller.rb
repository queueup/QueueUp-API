# frozen_string_literal: true

module V1
  class SuggestionsController < ApplicationController
    before_action :authenticate_user!

    def index
      @game_profile = current_user.game_profiles.find(params[:game_profile_id])
      @suggestions = GameProfile.eligible_for(@game_profile)
      league_of_legends_filters if @game_profile.resource_type == 'LeagueOfLegendsProfile'

      render json: @suggestions.first(25)
    end

    private

    def league_of_legends_filters
      @suggestions = @suggestions.joins(
        "JOIN league_of_legends_profiles
        ON league_of_legends_profiles.id = game_profiles.resource_id"
      )
      @suggestions = @suggestions.where(
        'LOWER(league_of_legends_profiles.region) = LOWER(?)',
        @game_profile.resource.region
      )
    end
  end
end
