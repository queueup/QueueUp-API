# frozen_string_literal: true

module V1
  class FortniteProfilesController < ApplicationController
    before_action :authenticate_user!, except: %i[create by_handle]
    load_and_authorize_resource except: %i[create by_handle]
    load_resource only: :create

    def show
      render json: @fortnite_profile
    end

    def by_handle
      @fortnite_profile = FortniteProfile.where(handle: params[:id]).first_or_initialize

      if @fortnite_profile.save
        render json: @fortnite_profile, status: :created
      else
        render json: @fortnite_profile.errors, status: :unprocessable_entity
      end
    end

    def create
      @fortnite_profile = FortniteProfile.where(handle: params[:fortnite_profile][:handle]).first_or_initialize

      @fortnite_profile.user_id = current_user.id if user_signed_in?

      if @fortnite_profile.save
        render json: @fortnite_profile, status: :created
      else
        render json: @fortnite_profile.errors, status: :unprocessable_entity
      end
    end

    def update
      if @fortnite_profile.update(update_params)
        render json: @fortnite_profile
      else
        render json: @fortnite_profile.errors, status: :unprocessable_entity
      end
    end

    def reload
      if @fortnite_profile.force_update
        render json: @fortnite_profile
      else
        render json: @fortnite_profile.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @fortnite_profile.game_profile&.destroy
    end

    private

    def create_params
      params.require(:fortnite_profile).permit(:handle)
    end

    def update_params
      params.require(:fortnite_profile).permit(
        :description,
        :picture_url,
        :duo,
        :squad,
        :fun,
        :try_hard
      )
    end
  end
end
