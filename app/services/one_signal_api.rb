# frozen_string_literal: true

class OneSignalApi
  attr_accessor :collapse_id,
                :contents,
                :data,
                :headings,
                :include_player_ids
  def initialize(props = {})
    @collapse_id = props[:collapse_id] || ''
    @contents = props[:contents] || {}
    @data = props[:data] || {}
    @headings = props[:headings] || {}
    @include_player_ids = props[:include_player_ids] || []
  end

  def create_notification
    return if @include_player_ids.to_a.empty?
    params = {
      app_id:             ENV['ONESIGNAL_APP_ID'],
      collapse_id:        @collapse_id,
      contents:           @contents,
      data:               @data,
      headings:           @headings,
      include_player_ids: @include_player_ids
    }
    send_notification params
  end

  def send_notification(params)
    uri = URI.parse('https://onesignal.com/api/v1/notifications')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.path,
                                  'Content-Type'  => 'application/json;charset=utf-8',
                                  'Authorization' => "Basic #{ENV['ONESIGNAL_API_KEY']}")
    request.body = params.as_json.to_json
    http.request(request)
  end
end
