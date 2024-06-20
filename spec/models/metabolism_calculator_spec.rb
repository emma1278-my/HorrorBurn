require 'rails_helper'

RSpec.describe MetabolismCalculator, type: :model do
  describe 'バリデーション' do
    it '体重、目標体重、目標達成期間があれば有効であること' do
      form = User.new(current_weight: 60, target_weight: 55, weight_achieved_date: Date.today + 30)
          expect(form).to be_valid
    end
    
    it '体重がなければ無効であること' do
      form = User.new(current_weight: nil, target_weight: 55, weight_achieved_date: Date.today + 30)
        expect(form).not_to be_valid
    end
    
    it '目標体重がなければ無効であること' do
      form = User.new(current_weight: 60, target_weight: nil, weight_achieved_date: Date.today + 30)
        expect(form).not_to be_valid
    end
    
    it '目標達成期間がなければ無効であること' do
      form = User.new(current_weight: 60, target_weight: 55, weight_achieved_date: nil)
        expect(form).not_to be_valid
    end
    
    it '身長、体重、目標体重が30より小さい場合無効であること' do
      form = User.new(current_weight: -30, target_weight: -30, weight_achieved_date: Date.today + 30)
        expect(form).not_to be_valid
    end
    
    it '身長、体重、目標体重が数値でなければ無効であること' do
      form = User.new(current_weight: '六〇', target_weight: '五十五', weight_achieved_date: Date.today + 30)
        expect(form).not_to be_valid
    end
  end
end