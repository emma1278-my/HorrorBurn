require 'rails_helper'

require 'rails_helper'

RSpec.describe MetabolismCalculator, type: :model do
  describe 'バリデーション' do
    it '体重と目標体重があれば有効であること' do
      user = User.new(
        email: 'test@example.com',
        name: 'Test User',
        password: 'password',
        password_confirmation: 'password',
        current_weight: 60,
        target_weight: 55
      )
      expect(user).to be_valid
    end
  end
end