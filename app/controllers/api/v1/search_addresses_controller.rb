# frozen_string_literal: true

class Api::V1::SearchAddressesController < Api::V1::BaseController
  def index
    url = 'https://discover.search.hereapi.com/v1/discover'
    results = Adapter::HereMaps.new(url, params['q'], params['at']).autosuggest_addresses
    render_object(results, :ok)
  end
end
