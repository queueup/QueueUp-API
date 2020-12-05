# frozen_string_literal: true

module V1
  class MatchesController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource

    # GET /matches
    def index
      @matches = current_user.matches

      @matches = @matches.preload(:last_message)
      @matches = @matches.where(match_memberships: { game_profile_id: params[:game_profile_id] }) if params[:game_profile_id].present?

      render json: @matches.uniq
    end

    # GET /matches/1
    def show
      render json: @match
    end

    # DELETE /matches/1
    def destroy
      @match.update(canceled_at: Time.zone.now)
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find(params[:id])
    end
  end
end
