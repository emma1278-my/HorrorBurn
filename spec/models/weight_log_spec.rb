# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeightLog, type: :model do
  let(:user) { create(:user) }
  describe 'バリデーションチェック' do
    it 'Userモデルとの関連付けされている' do
      should belong_to(:user)
    end
  end
 
  describe '独自メソッドのチェック' do
    it '記録日が今日であることを確認する' do
      user = FactoryBot.create(:user)
      weight_log = FactoryBot.create(:weight_log, user:)
      expect(WeightLog.weight_log_for_day(user)).to eq weight_log
    end
  end
end
