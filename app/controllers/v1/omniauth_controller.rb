# frozen_string_literal: true

module V1
  class OmniauthController < ApplicationController
    def facebook
      @user = User.facebook(params[:access_token], current_user)

      if @user.save
        response.headers.merge!(@user.create_new_auth_token)
        render json: @user, status: :ok
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    def google
      @user = User.google(params[:id_token], current_user)

      if @user.save
        response.headers.merge!(@user.create_new_auth_token)
        render json: @user, status: :ok
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  end
end
