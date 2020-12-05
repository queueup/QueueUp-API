# frozen_string_literal: true

class StatusController < ApplicationController
  before_action :database_connection

  def index
    render json: {
      database: @connected_database,
      riot_ddragon_version: RIOT_DDRAGON_VERSION,
      status: true
    }, status: :ok
  end

  private

  def database_connection
    ActiveRecord::Base.establish_connection
    ActiveRecord::Base.connection
    @connected_database = ActiveRecord::Base.connected?
  rescue StandardError
    @connected_database = false
  end
end
