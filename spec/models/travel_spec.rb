# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Travel, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:departure_time) }
    it { should validate_presence_of(:capacity) }
    it { should validate_presence_of(:owner_comment) }
  end
end
