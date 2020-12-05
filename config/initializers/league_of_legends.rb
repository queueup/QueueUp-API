# frozen_string_literal: true

response = HTTParty.get('https://ddragon.leagueoflegends.com/api/versions.json')
RIOT_DDRAGON_VERSION = JSON.parse(response.body).first
RIOT_DDRAGON_ENDPOINT = 'https://ddragon.leagueoflegends.com/cdn'
RIOT_MATCHES_CHECK_PERIOD = 1.hour
RIOT_API_REGIONS = [
  {
    region:   'BR',
    platform: 'BR1',
    endpoint: 'br1.api.riotgames.com'
  },
  {
    region:   'EUNE',
    platform: 'EUN1',
    endpoint: 'eun1.api.riotgames.com'
  },
  {
    region:   'EUW',
    platform: 'EUW1',
    endpoint: 'euw1.api.riotgames.com'
  },
  {
    region:   'JP',
    platform: 'JP1',
    endpoint: 'jp1.api.riotgames.com'
  },
  {
    region:   'KR',
    platform: 'KR',
    endpoint: 'kr.api.riotgames.com'
  },
  {
    region:   'LAN',
    platform: 'LA1',
    endpoint: 'la1.api.riotgames.com'
  },
  {
    region:   'LAS',
    platform: 'LA2',
    endpoint: 'la2.api.riotgames.com'
  },
  {
    region:   'NA',
    platform: 'NA1',
    endpoint: 'na1.api.riotgames.com'
  },
  {
    region:   'OCE',
    platform: 'OC1',
    endpoint: 'oc1.api.riotgames.com'
  },
  {
    region:   'TR',
    platform: 'TR1',
    endpoint: 'tr1.api.riotgames.com'
  },
  {
    region:   'RU',
    platform: 'RU',
    endpoint: 'ru.api.riotgames.com'
  },
  {
    region:   'PBE',
    platform: 'PBE1',
    endpoint: 'pbe1.api.riotgames.com'
  }
].freeze
