# frozen_string_literal: true

class Interaction < ApplicationRecord
  after_commit :start_worker, on: :create

  belongs_to :game_profile
  has_one :user, through: :game_profile
  belongs_to :target, class_name: 'GameProfile', inverse_of: :interactions

  protected

  def start_worker
    InteractionsWorker.perform_async(id)
  end
end
