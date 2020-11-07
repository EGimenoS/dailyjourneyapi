# frozen_string_literal: true

class Api::V1::SearchAddressesController < Api::V1::BaseController
  def index
    results = RestClient.get 'https://discover.search.hereapi.com/v1/discover',
                             { params: { apikey: ENV['here_maps_api_key'], at: '39.48728,-0.36593', q: 'barrio hospital', limit: 50 } }
    render_object(results, :ok)
  end
end
