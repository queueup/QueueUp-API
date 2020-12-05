# frozen_string_literal: true

module V1
  class LeagueOfLegendsProfilesController < ApplicationController
    before_action :authenticate_user!, except: %i[create by_summoner]
    load_and_authorize_resource except: %i[create by_summoner]
    load_resource only: :create

    def show
      render json: @league_of_legends_profile
    end

    def by_summoner
      @league_of_legends_profile = LeagueOfLegendsProfile.custom_find_by_summoner(
        params[:region],
        params[:summoner_name]
      )
      show
    end

    def create
      @league_of_legends_profile = LeagueOfLegendsProfile.custom_find_by_summoner(
        params[:league_of_legends_profile][:region],
        params[:league_of_legends_profile][:summoner_name]
      )
      @league_of_legends_profile.user_id = current_user.id if user_signed_in?
      if @league_of_legends_profile.save
        render json: @league_of_legends_profile, status: :created
      else
        render json: @league_of_legends_profile.errors, status: :unprocessable_entity
      end
    end

    def update
      if @league_of_legends_profile.update(update_params)
        render json: @league_of_legends_profile
      else
        render json: @league_of_legends_profile.errors, status: :unprocessable_entity
      end
    end

    def reload
      if @league_of_legends_profile.force_update
        render json: @league_of_legends_profile
      else
        render json: @league_of_legends_profile.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @league_of_legends_profile.game_profile&.destroy
    end

    private

    def create_params
      params.require(:league_of_legends_profile).permit(
        :summoner_name,
        :region
      )
    end

    def update_params
      params.require(:league_of_legends_profile).permit(
        :description,
        champions: [],
        roles:     []
      )
    end
  end
end
