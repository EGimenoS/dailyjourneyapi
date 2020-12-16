# frozen_string_literal: true

class Api::V1::ProfileTravelsController < Api::V1::BaseController
  before_action :authenticate_and_set_user
  def index
    travels = Travel.joins(:participants).where('participants.user_id' => current_user.id).or(Travel.joins(:participants).where('travels.owner_id' => current_user.id))
    render json: travels, status: :ok, each_serializer: TravelDetailSerializer
  end
end
