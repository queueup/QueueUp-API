# frozen_string_literal: true

class FortniteProfile < ApplicationRecord
  include GameProfileClass

  has_one :game_profile, as: :resource, dependent: :destroy, inverse_of: :resource

  validates :handle, presence: true, uniqueness: true

  before_validation :set_fortnite_profile, on: :create
  after_create :force_update

  def force_update(force = false)
    return true if !scout_updated_at.nil? && scout_updated_at > Time.zone.now - 1.day && !force

    response = ScoutApi.fortnite_stats(player_id)

    [
      {
        id: 'p2.br.m0.alltime',
        value: 'solo'
      },
      {
        id: 'p10.br.m0.alltime',
        value: 'duo'
      },
      {
        id: 'p9.br.m0.alltime',
        value: 'squad'
      }
    ].each do |segment|
      queue = response.detect do |result|
        !result['metadata'].detect do |metadatum|
          metadatum['key'] == 'segment' && metadatum['value'] == segment[:id]
        end.nil?
      end

      [
        { scout_key: 'kills', queueup_key: 'kills' },
        { scout_key: 'matchesPlayed', queueup_key: 'played' },
        { scout_key: 'killDeathRatio', queueup_key: 'kd' }
      ].each do |stat|
        next if queue.nil?
        self["#{stat[:queueup_key]}_#{segment[:value]}"] = queue['stats'].detect do |queue_stat|
          queue_stat['metadata']['key'] == stat[:scout_key]
        end['value']
      end
    end

    self.scout_updated_at = Time.zone.now

    save
  end

  protected

  def set_fortnite_profile
    response = ScoutApi.fortnite_profile(handle)

    return errors.add(:handle, 'does not exist') if response.nil?

    self.handle = response['persona']['handle']
    self.picture_url = response['persona']['pictureUrl']
    self.platform = response['persona']['platform']['slug']
    self.player_id = response['player']['playerId']
  end
end
