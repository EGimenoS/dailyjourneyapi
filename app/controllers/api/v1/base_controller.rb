# frozen_string_literal: true

class Api::V1::BaseController < ApplicationController
  include Renderer
  rescue_from ActiveRecord::RecordNotFound do |error|
    render_errors(error, :not_found)
  end
end
