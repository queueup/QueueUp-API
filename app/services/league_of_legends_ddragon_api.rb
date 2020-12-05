# frozen_string_literal: true

module LeagueOfLegendsDdragonApi
  module_function

  def formatted_champions
    temp_champions = champions
    temp_champions.keys.map do |key|
      champion = temp_champions[key]
      champion['icon'] = champion_icon_url(key)
      champion['splash'] = champion_splash_url(key)
      champion
    end
  end

  def champions
    response = HTTParty.get(
      "#{RIOT_DDRAGON_ENDPOINT}/#{RIOT_DDRAGON_VERSION}/data/en_US/champion.json"
    )
    if response.success?
      JSON.parse(response.body)['data']
    else
      []
    end
  end

  def champion_icon_url(champion)
    "#{RIOT_DDRAGON_ENDPOINT}/#{RIOT_DDRAGON_VERSION}/img/champion/#{champion}.png"
  end

  def champion_splash_url(champion)
    "#{RIOT_DDRAGON_ENDPOINT}/img/champion/splash/#{champion}_0.jpg"
  end

  # rubocop:disable Style/AccessModifierDeclarations
  class << self
    private :champion_icon_url
    private :champion_splash_url
  end
  # rubocop:enable Style/AccessModifierDeclarations
end
