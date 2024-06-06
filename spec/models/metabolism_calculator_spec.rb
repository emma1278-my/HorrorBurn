require 'rails_helper'

RSpec.describe MetabolismCalculator, type: :model do 
 
describe 'if user calculate' do
  let(:current_weight) { 80.0 }
  let(:target_weight) { 70.0 }
  let(:valid_params) { { current_weight: current_weight, target_weight: target_weight } }

  context 'with valid params' do
    it 'updates user data' do
      post :create, params: valid_params
      expect(user.current_weight).to eq(current_weight)
      expect(user.target_weight).to eq(target_weight)
      expect(user.remaining_weight).to eq(current_weight - target_weight)
      expect(user.target_calorie).to eq((current_weight - target_weight) * 7200)
      expect(user.remaining_runtime).to be_present
    end

    it 'renders the show template' do
      post :create, params: valid_params
      expect(response).to render_template(:show)
    end
  end

  context 'with invalid params' do
    let(:invalid_params) { { current_weight: 'invalid', target_weight: 'invalid' } }

    it 'does not update user data' do
      expect {
        post :create, params: invalid_params
      }.not_to change { user.reload.attributes }
    end

    it 'renders the show template' do
      post :create, params: invalid_params
      expect(response).to render_template(:show)
    end
  end
end

describe 'if user recalculate' do
    user.update(current_weight: 80.0, target_weight: 70.0)
  end

  it 'resets user data' do
    delete :destroy
    expect(user.current_weight).to be_nil
    expect(user.target_weight).to be_nil
    expect(user.remaining_weight).to be_nil
    expect(user.target_calorie).to be_nil
    expect(user.remaining_runtime).to be_nil
  end

  it 'redirects to new_metabolism_calculators_path' do
    delete :destroy
    expect(response).to redirect_to(new_metabolism_calculators_path)
  end
end
end