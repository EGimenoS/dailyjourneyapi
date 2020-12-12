# frozen_string_literal: true

class Api::V1::ParticipantsController < Api::V1::BaseController
  before_action :authenticate_and_set_user
  before_action :set_participant, only: %i[destroy update]
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
    @participant.destroy
    head 204
  end

  private

  def set_participant
    @participant = Participant.find(params[:id])
  end

  def participant_params
    params.require(:participant).permit(:id, :travel_id, :status)
  end
end
