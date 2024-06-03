require 'rails_helper'

RSpec.describe WeightRecord, type: :model do
  describe 'バリエーション' do
    it 'userとの関連付けがされているか' do
      should belong_to(:user)
    end
  end

  describe 'カスタムメソッドチェック' do
    it '日付のレコードが当日であるか' do
      user = FactoryBot.create(:user)
      weight_log = FactoryBot.create(:weight_log, user:)
      expect(WeightLog.weight_log_for_day(user)).to eq weight_log
    end
  end
end
