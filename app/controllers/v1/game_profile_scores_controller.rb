# frozen_string_literal: true

module V1
  class GameProfileScoresController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource

    # GET /game_profile_scores
    def index
      @game_profile_scores = current_user.game_profile_scores
      if params[:target_game_profile_id].present?
        @game_profile_scores = @game_profile_scores.where(target_game_profile_id: params[:target_game_profile_id])
      end
      @game_profile_scores = @game_profile_scores.where(score_id: params[:score_id]) if params[:score_id].present?

      render json: @game_profile_scores
    end

    # GET /game_profile_scores/1
    def show
      render json: @game_profile_score
    end

    # POST /game_profile_scores
    def create
      @game_profile_score = GameProfileScore.new(game_profile_score_params)

      if @game_profile_score.save
        render json: @game_profile_score, status: :created
      else
        render json: @game_profile_score.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /game_profile_scores/1
    def update
      if @game_profile_score.update(game_profile_score_params)
        render json: @game_profile_score
      else
        render json: @game_profile_score.errors, status: :unprocessable_entity
      end
    end

    # DELETE /game_profile_scores/1
    def destroy
      @game_profile_score.destroy
    end

    private

    # Only allow a trusted parameter "white list" through.
    def game_profile_score_params
      params.require(:game_profile_score).permit(:game_profile_id, :target_game_profile_id, :score_id)
    end
  end
end
