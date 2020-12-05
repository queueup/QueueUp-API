# frozen_string_literal: true

module V1
  class InteractionsController < ApplicationController
    load_and_authorize_resource

    def create
      if @interaction.save
        render json: @interaction, status: :created
      else
        render json: @interaction.errors, status: :unprocessable_entity
      end
    end

    # Only allow a trusted parameter "white list" through.
    def create_params
      params.require(:interaction).permit(:game_profile_id, :target_id, :liked)
    end
  end
end
