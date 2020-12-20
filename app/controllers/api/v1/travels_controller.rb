# frozen_string_literal: true

class Api::V1::TravelsController < Api::V1::BaseController
  before_action :authenticate_and_set_user, only: %i[create update destroy]
  before_action :set_travel, only: %i[update destroy]

  def create
    travel = current_user.travels.build(travel_params)
    if travel.save
      render json: travel, status: :ok, serializer: TravelDetailSerializer
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

  def update
    if @travel.update(travel_params)
      render json: @travel, status: :ok, serializer: TravelDetailSerializer
    else
      render_errors(@travel)
    end
  end

  def destroy
    if @travel.destroy
      head 204
    else
      render_errors(@travel)
    end
  end

  private

  def set_travel
    @travel = Travel.find(params[:id])
  end

  def travel_params
    params.require(:travel).permit(:departure_time, :periodicity, :owner_comment, :capacity, origin_attributes: %i[longitude latitude id address],
                                                                                             destination_attributes: %i[longitude latitude id address])
  end
end
