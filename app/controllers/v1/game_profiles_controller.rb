# frozen_string_literal: true

module V1
  class GameProfilesController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource

    def index
      @game_profiles = current_user.game_profiles

      @game_profiles = @game_profiles.where(resource_type: params[:resource_type]) if params[:resource_type].present?

      render json: @game_profiles
    end

    def show
      render json: @game_profile
    end

    def destroy
      @game_profile.destroy
    end
  end
end
