# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeightLog, type: :model do
  let(:user) { create(:user) }
  describe 'Validations' do
    it 'is associated with a user' do
      should belong_to(:user)
    end
  end

  describe 'Custom method checks' do
    it 'checks if the record date is today' do
      user = FactoryBot.create(:user)
      weight_log = FactoryBot.create(:weight_log, user:)
      expect(WeightLog.weight_log_for_day(user)).to eq weight_log
    end
  end
end
