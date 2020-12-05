# frozen_string_literal: true

class ApplicationController < ActionController::API
  include CanCan::ControllerAdditions
  include DeviseTokenAuth::Concerns::SetUserByToken

  after_action :update_connected_at

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  rescue_from CanCan::AccessDenied do
    if current_user
      render nothing: true, status: :forbidden
    else
      render nothing: true, status: :unauthorized
    end
  end

  rescue_from ActiveRecord::RecordNotFound, Ambry::NotFoundError do
    render nothing: true, status: :not_found
  end

  protected

  def update_connected_at
    current_user.game_profiles.update(connected_at: Time.zone.now) if user_signed_in?
  end
end
