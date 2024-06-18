require 'rails_helper'

RSpec.describe MetabolismCalculator, type: :model do 
  describe '計算する' do
    let(:user) { create(:user) }
    let(:current_weight) { 80.0 }
    let(:target_weight) { 70.0 }
    let(:valid_params) { { current_weight: current_weight, target_weight: target_weight } }
  
    context '有効なパラメーターの場合' do
      it 'ユーザーデータを更新する' do
        post :create, params: valid_params
        expect(user.current_weight).to eq(current_weight)
        expect(user.target_weight).to eq(target_weight)
        expect(user.remaining_weight).to eq(current_weight - target_weight)
        expect(user.target_calorie).to eq((current_weight - target_weight) * 7200)
        expect(user.remaining_runtime).to be_present
      end
  
      it '計算結果の表示' do
        post :create, params: valid_params
        expect(response).to render_template(:show)
      end
    end
  
    context '無効なパラメーターの場合' do
      let(:invalid_params) { { current_weight: '無効', target_weight: '無効' } }
  
      it 'ユーザーデータを更新しない' do
        expect {
          post :create, params: invalid_params
        }.not_to change { user.reload.attributes }
      end
    end
  end
end