# frozen_string_literal: true

module GameProfileClass
  extend ActiveSupport::Concern

  included do
    after_save :create_game_profile

    attr_accessor :user_id

    protected

    def create_game_profile
      if user_id.nil?
        GameProfile.where(resource: self, user_id: user_id).destroy_all
      else
        GameProfile.where(
          resource: self, user_id: user_id
        ).first_or_create
      end
    end
  end
end
