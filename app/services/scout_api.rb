# frozen_string_literal: true

module ScoutApi
  def self.fortnite_profile(username = '')
    results = request_api("
      {
        players(identifier: \"#{username}\", title: \"fortnite\") {
          results {
            player {
              playerId
            }
            persona {
              handle
              platform {
                slug
              }
              pictureUrl
            }
          }
        }
      }")

    return nil if results.nil?

    results = results['data']['players']['results']

    return nil if results.size.zero?

    results.detect { |result| result['persona']['handle'].casecmp(username)&.zero? }
  end

  def self.fortnite_stats(player_id = '')
    request_api("
      {
        player(title: \"fortnite\", id: \"#{player_id}\", segment: \"alltime\") {
          segments {
            metadata {
              key
              name
              value
              displayValue
            }
            stats {
              metadata {
                key
                name
                isReversed
              }
              value
              displayValue
            }
          }
        }
      }")['data']['player']['segments']
  end

  def self.request_api(query = '', variables = {})
    response = HTTParty.post(
      'https://api.scoutsdk.com/graph',
      body: { query: query.delete("\n"), variables: variables }.to_json,
      headers: {
        'Accept' => 'application/com.scoutsdk.graph+json; version=1.1.0; charset=utf8',
        'content-type' => 'application/json',
        'Scout-App' => ENV['FORTNITE_API_KEY']
      }
    )
    JSON.parse(response.body)
  end
end
