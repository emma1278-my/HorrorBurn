require 'rails_helper'

RSpec.describe MetabolismCalculator, type: :model do
  describe '計算する' do
    let(:current_weight) { 80.0 }
    let(:target_weight) { 70.0 }
    let(:calculator) { described_class.new(current_weight, target_weight) }

    context '有効なパラメーターの場合' do
      it '目標体重まで何キロか算出する' do
        expect(calculator.remaining_weight).to eq(current_weight - target_weight)
      end

      it '目標減量カロリーを算出' do
        expect(calculator.target_calorie).to eq((current_weight - target_weight) * 7200)
      end
    end

    context 'パラメーター無効' do
      let(:invalid_calculator) { described_class.new('invalid', 'invalid') }

      it 'エラーがでる' do
        expect { invalid_calculator.remaining_weight }.to raise_error(ArgumentError)
      end
    end
  end
end