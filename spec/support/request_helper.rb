# frozen_string_literal: true

module JsonHelpers
  def json
    if defined? response_body
      body = response_body
    elsif defined? response
      body = response.body
    else
      return {}
    end
    symbolize_keys(JSON.parse(body))
  end

  private

  def symbolize_keys(json)
    case json
    when Hash then Hash[json.map { |k, v| [k.to_sym, symbolize_keys(v)] }]
    when Array then json.map { |e| symbolize_keys(e) }
    else json
    end
  end
end

RSpec.configure do |config|
  config.include JsonHelpers
end
