# frozen_string_literal: true

module Adapter
  class HereMaps
    API_KEY = ENV['here_maps_api_key']

    def initialize(base_url, query, at = '39.48728,-0.36593')
      @base_url = base_url
      @config = set_config
      @query = query
      @at = at
    end

    def autosuggest_addresses
      req_params = { at: @at, q: @query }
      results = RestClient.get @base_url, { params: @config.merge(req_params) }
      results = JSON.parse(results)
      results['items'].map do |item|
        { address: item['title'], lat: item['position']['lat'], long: item['position']['lng'] }
      end
    end

    private

    def set_config
      { apikey: API_KEY, limit: 5 }
    end
  end
end
