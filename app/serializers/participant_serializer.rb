# frozen_string_literal: true

class ParticipantSerializer < BaseSerializer
  attributes :travel_id, :status, :user_id, :user_name

  def user_name
    User.find(object.user_id).name
  end
end
