# frozen_string_literal: true

class Api::V1::ParticipantsController < Api::V1::BaseController
  before_action :authenticate_and_set_user
  before_action :set_participant, only: %i[destroy update]
<<<<<<< HEAD
  before_action :require_authorized_for_current_participant, only: %i[destroy update]
=======
  before_action :require_authorized_for_current_participant, only: %i[create destroy update]
>>>>>>> 6dd072d9471f3b980ecff9d7ffd33ca0bb98de4e
  def create
    participant = current_user.participants.build(participant_params)
    if participant.save
      render_object(participant)
    else
      render_errors(participant.errors)
    end
  end

  def update
    if @participant.update(participant_params)
      render_object(@participant)
    else
      render_errors(@participant)
    end
  end

  def destroy
    if @participant.destroy
      head 204
    else
      render_errors(@participant)
    end
  end

  private

  def require_authorized_for_current_participant
    render json: { error: 'Acceso no autorizado' }, status: :unauthorized if @participant.user != current_user && @participant.travel.owner_id != current_user.id
  end

  def set_participant
    @participant = Participant.find(params[:id])
  end

  def participant_params
    params.require(:participant).permit(:id, :travel_id, :status)
  end
end
