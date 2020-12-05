# frozen_string_literal: true

module V1
  class MessagesController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource

    # GET /messages
    def index
      @messages = current_user.messages

      if params[:match_id].present?
        @messages = @messages.where(match_id: params[:match_id])
        current_user.match_memberships.where(match_id: params[:match_id]).update(messages_read_at: Time.zone.now)
      end

      render json: @messages
    end

    # GET /messages/1
    def show
      current_user.match_memberships.where(match_id: @message.match_id).update(messages_read_at: Time.zone.now)
      render json: @message
    end

    # POST /messages
    def create
      if @message.save
        render json: @message, status: :created
      else
        render json: @message.errors, status: :unprocessable_entity
      end
    end

    # DELETE /messages/1
    def destroy
      @message.destroy
    end

    private

    # Only allow a trusted parameter "white list" through.
    def create_params
      params.require(:message).permit(:content, :game_profile_id, :match_id)
    end
  end
end
