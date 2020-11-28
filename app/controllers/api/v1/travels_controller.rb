# frozen_string_literal: true

class Api::V1::TravelsController < Api::V1::BaseController
  before_action :authenticate_and_set_user, only: %i[create update]

  def create
    puts current_user.name
    travel = current_user.travels.build(travel_params)
    if travel.save
      render_object(travel, :created)
    else
      render_errors(travel.errors)
    end
  end

  def index
    travels = Travel.includes(:destination).near_of(params[:destination_latitude], params[:destination_longitude])
    render_object(travels, :ok)
  end

  def show
    travel = Travel.find(params[:id])
    render json: travel, status: :ok, serializer: TravelDetailSerializer
  end

  def travel_params
    params.require(:travel).permit(:departure_time, :owner_comment, :capacity, origin_attributes: %i[longitude latitude id address],
                                                                               destination_attributes: %i[longitude latitude id address])
  end
end
