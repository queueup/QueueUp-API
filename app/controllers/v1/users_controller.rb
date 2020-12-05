# frozen_string_literal: true

module V1
  class UsersController < ApplicationController
    before_action :authenticate_user!

    # GET /v1/user
    def show
      render json: current_user
    end

    # PATCH/PUT /v1/user
    def update
      if current_user.update(user_params)
        render json: current_user
      else
        render json: current_user.errors, status: :unprocessable_entity
      end
    end

    private

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:favorite_badge, locales: [])
    end
  end
end
