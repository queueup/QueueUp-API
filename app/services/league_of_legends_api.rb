# frozen_string_literal: true

class LeagueOfLegendsApi
  attr_accessor :region,
                :account_id,
                :ranked_data,
                :summoner_name,
                :summoner_id,
                :summoner_level,
                :champions,
                :profile_icon_id

  def initialize(props = {})
    @summoner_name = props[:summoner_name]
    @region = props[:region]
    @endpoint = get_region_endpoint(@region)
    if props[:summoner_id].nil? || props[:account_id].nil?
      fetch_summoner_id
    else
      @account_id = props[:account_id]
      @summoner_id = props[:summoner_id]
    end
  end

  def fetch_ranked_data
    @ranked_data = request_api "lol/league/v4/entries/by-summoner/#{@summoner_id}" unless @summoner_id.nil?
  end

  def fetch_summoner
    response = request_api "lol/summoner/v4/summoners/#{URI.escape(@summoner_id.to_s)}"

    return if response.nil? || response['id'].nil? || response['profileIconId'].nil?

    update_data response
  end

  def fetch_champions
    return if @summoner_id.nil?

    @champions = request_api("lol/champion-mastery/v4/champion-masteries/by-summoner/#{@summoner_id}").to_a
    @champions = @champions.pluck('championId')
    @champions[0..4].compact
  end

  def fetch_last_roles
    matches = request_api "lol/match/v4/matchlists/by-account/#{@account_id}"
    matches = matches['matches']
    roles = %w[TOP JUNGLE MID BOTTOM SUPPORT].map do |role|
      {
        role:  role,
        count: matches.nil? ? 0 : matches.count { |match| match['lane'] == role }
      }
    end
    roles.sort_by { |obj| obj[:count] }.reverse.first(2).pluck(:role)
  end

  def fetch_matches(opts = {})
    matches = request_api "lol/match/v4/matchlists/by-account/#{@account_id}?beginTime=#{opts[:begin_time].to_i * 1000}"
    matches.key?('matches') ? matches['matches'] : []
  end

  private

  def update_data(response)
    @profile_icon_id = response['profileIconId']
    @summoner_level = response['summonerLevel']
    @summoner_name = response['name']
    @account_id = response['accountId']
    @summoner_id = response['id']
  end

  def fetch_summoner_id
    response = request_api "lol/summoner/v4/summoners/by-name/#{URI.escape(@summoner_name)}"

    return if response.nil? || response['id'].nil? || response['profileIconId'].nil?

    update_data response
  end

  def get_region_endpoint(region)
    RIOT_API_REGIONS.select { |r| r[:region].casecmp(region.downcase).zero? }.first[:endpoint] unless region.nil?
  end

  def request_api(req)
    if @endpoint.nil?
      nil
    else
      response = HTTParty.get(
        "https://#{@endpoint}/#{req}",
        headers: { 'X-Riot-Token' => ENV['RIOT_API_KEY'] }
      )
      JSON.parse(response.body)
    end
  end
end
