# frozen_string_literal: true

module V1
  class DevicesController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource

    # GET /devices
    def index
      @devices = current_user.devices

      render json: @devices
    end

    # GET /devices/1
    def show
      render json: @device
    end

    # POST /devices
    def create
      @device = Device.find_or_create_by(device_params)

      @device.user = current_user

      if @device.save
        render json: @device, status: :created
      else
        render json: @device.errors, status: :unprocessable_entity
      end
    end

    # DELETE /devices/1
    def destroy
      @device.destroy
    end

    private

    # Only allow a trusted parameter "white list" through.
    def device_params
      params.require(:device).permit(:player_id)
    end
  end
end
