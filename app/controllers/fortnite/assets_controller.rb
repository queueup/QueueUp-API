# frozen_string_literal: true

module Fortnite
  class AssetsController < ApplicationController
    def avatars
      render json: {
        base_path: '/fortnite/avatars',
        avatars: FORTNITE_AVATARS
      }
    end
  end
end
