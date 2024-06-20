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
    
    it '体重がなければ無効であること' do
      user = User.new(
        email: 'test@example.com',
        name: 'Test User',
        password: 'password',
        password_confirmation: 'password',
        current_weight: nil,
        target_weight: 55
      )
      expect(user).not_to be_valid
    end
    
    it '目標体重がなければ無効であること' do
      user = User.new(
        email: 'test@example.com',
        name: 'Test User',
        password: 'password',
        password_confirmation: 'password',
        current_weight: 60,
        target_weight: nil
      )
      expect(user).not_to be_valid
    end
    
    it '体重と目標体重が30より小さい場合無効であること' do
      user = User.new(
        email: 'test@example.com',
        name: 'Test User',
        password: 'password',
        password_confirmation: 'password',
        current_weight: -30,
        target_weight: -30
      )
      expect(user).not_to be_valid
    end
    
    it '体重と目標体重が数値でなければ無効であること' do
      user = User.new(
        email: 'test@example.com',
        name: 'Test User',
        password: 'password',
        password_confirmation: 'password',
        current_weight: '六〇',
        target_weight: '五十五'
      )
      expect(user).not_to be_valid
    end
  end
end