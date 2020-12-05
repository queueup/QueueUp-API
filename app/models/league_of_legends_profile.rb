# frozen_string_literal: true

class LeagueOfLegendsProfile < ApplicationRecord
  include GameProfileClass

  default_scope { includes(:league_of_legends_positions) }

  has_one :game_profile, as: :resource, dependent: :destroy, inverse_of: :resource
  has_many :league_of_legends_matches, dependent: :destroy
  has_many :league_of_legends_positions, dependent: :destroy

  after_initialize :set_default_values
  before_validation :set_api_summoner, on: :create
  after_create :force_update

  validates :summoner_name, presence: true, uniqueness: { scope: :region }
  validates :summoner_id, presence: true, uniqueness: true
  validates :region, presence: true

  accepts_nested_attributes_for :league_of_legends_positions

  def force_update(force = false)
    return league_of_legends_positions if riot_updated_at > Time.zone.now - 1.day && !force

    league_of_legends_positions.destroy_all # Destroy the old records

    l = LeagueOfLegendsApi.new(
      account_id:    account_id,
      summoner_name: summoner_name,
      region:        region,
      summoner_id:   summoner_id
    )
    l.fetch_summoner
    update_fields_from_api(l)

    self.league_of_legends_positions_attributes = LeagueOfLegendsPosition.from_ranked_data(l.fetch_ranked_data)
    save
  end

  def self.custom_find_by_summoner(region, summoner_name)
    lp = LeagueOfLegendsProfile.where(
      'LOWER(summoner_name) = ? AND LOWER(region) = ?', summoner_name.to_s.downcase, region.to_s.downcase
    ).first_or_create do |profile|
      profile.region = region.to_s
      profile.summoner_name = summoner_name.to_s
    end
    lp.reload
    lp
  end

  private

  def set_api_summoner
    return if region.nil? || summoner_name.nil?

    l = LeagueOfLegendsApi.new(
      summoner_name: summoner_name,
      region:        region
    )
    self.account_id = l.account_id
    self.summoner_id = l.summoner_id
    self.champions = l.fetch_champions
    self.roles = l.fetch_last_roles
    self.league_of_legends_positions_attributes = LeagueOfLegendsPosition.from_ranked_data(l.fetch_ranked_data)
    update_fields_from_api(l)
  end

  def update_fields_from_api(response)
    self.summoner_name = response.summoner_name
    self.profile_icon_id = response.profile_icon_id
    self.summoner_level = response.summoner_level
    self.riot_updated_at = Time.zone.now
    self.profile_icon_url = "#{RIOT_DDRAGON_ENDPOINT}/#{RIOT_DDRAGON_VERSION}/img/profileicon/#{response.profile_icon_id}.png"

    return if game_profile.nil?

    game_profile&.noob = response.summoner_level.to_i < 30
    game_profile.name = summoner_name
    game_profile.avatar_url = profile_icon_url
    game_profile.save
  end

  def set_default_values
    self.champions    ||= []
    self.roles        ||= []
  end
end
