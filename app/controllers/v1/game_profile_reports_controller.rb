# frozen_string_literal: true

module V1
  class GameProfileReportsController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource

    def create
      if @game_profile_report.save
        render json: @game_profile_report, status: :created
      else
        render json: @game_profile_report.errors, status: :unprocessable_entity
      end
    end

    private

    # Only allow a trusted parameter "white list" through.
    def create_params
      params.require(:game_profile_report).permit(:game_profile_id, :target_profile_id, :reason, :description)
    end
  end
end
