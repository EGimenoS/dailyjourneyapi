# frozen_string_literal: true

class Api::V1::TravelsController < Api::V1::BaseController
  before_action :authenticate_and_set_user, only: %i[create update destroy]
  before_action :set_travel, only: %i[update destroy show]
  before_action :require_authorized_for_current_travel, only: %i[destroy update]

  def create
    travel = current_user.travels.build(travel_params)
    if travel.save
      render json: travel, status: :ok, serializer: TravelDetailSerializer
    else
      render_errors(travel.errors)
    end
  end

  def index
    travels = Travel.includes(:destination).near_of(params[:destination_latitude], params[:destination_longitude], params[:distance] || 3) # default distance 3km
    render_object(travels, :ok)
  end

  def show
    render json: @travel, status: :ok, serializer: TravelDetailSerializer
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

  def require_authorized_for_current_travel
    render json: { error: 'Acceso no autorizado' }, status: :unauthorized if @travel.owner_id != current_user.id
  end

  def travel_params
    params.require(:travel).permit(:departure_time, :periodicity, :owner_comment, :capacity, origin_attributes: %i[longitude latitude id address],
                                                                                             destination_attributes: %i[longitude latitude id address])
  end
end
