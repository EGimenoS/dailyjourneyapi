# frozen_string_literal: true

class Api::V1::SearchAddressesController < Api::V1::BaseController
  def index
    apikey = ENV['here_maps_api_key']
    limit = 5
    config = { apikey: apikey, limit: limit }
    req_params = { at: params['at'], q: params['q'] }
    results = RestClient.get 'https://discover.search.hereapi.com/v1/discover', { params: config.merge(req_params) }
    render_object(results, :ok)
  end
end
