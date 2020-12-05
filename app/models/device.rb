# frozen_string_literal: true

class Device < ApplicationRecord
  belongs_to :user, optional: false

  validates :player_id, presence: true, uniqueness: true
end
