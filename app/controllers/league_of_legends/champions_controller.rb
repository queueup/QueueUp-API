# frozen_string_literal: true

module LeagueOfLegends
  class ChampionsController < ApplicationController
    # before_action :authenticate_user!

    def index
      render json: LeagueOfLegendsDdragonApi.formatted_champions
    end
  end
end
