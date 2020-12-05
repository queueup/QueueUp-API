# frozen_string_literal: true

module V1
  class BadgesController < ApplicationController
    before_action :set_badge, only: [:show]

    # GET /v1/badges
    def index
      @badges = Merit::Badge.all

      render json: @badges
    end

    # GET /v1/badges/1
    def show
      render json: @badge
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_badge
      @badge = Merit::Badge.find(params[:id].to_i)
    end
  end
end
