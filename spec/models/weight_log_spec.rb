# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeightLog, type: :model do
  let(:user) { create(:user) }
  describe 'アソシエーション確認' do
    it 'Userモデルとの関連付けされている' do
      should belong_to(:user)
    end
  end
 
  describe '独自メソッドのチェック' do
    it 'weight_logからcreated_atが今日の日付のレコードを検索しているか' do
      user = FactoryBot.create(:user)
      weight_log = FactoryBot.create(:weight_log, user:)
      expect(WeightLog.weight_log_for_day(user)).to eq weight_log
    end
  end
end
