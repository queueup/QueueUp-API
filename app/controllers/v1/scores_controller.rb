# frozen_string_literal: true

module V1
  class ScoresController < ApplicationController
    before_action :set_score, only: %i[show]

    # GET /scores
    def index
      @scores = Score.all

      render json: @scores
    end

    # GET /scores/1
    def show
      render json: @score
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_score
      @score = Score.find(params[:id])
    end
  end
end
