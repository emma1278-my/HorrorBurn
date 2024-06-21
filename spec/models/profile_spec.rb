# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'バリデーション' do
    context '有効な場合' do
      it '有効である' do
        expect(user).to be_valid
      end
    end

    context '無効な場合' do
      before { user.assign_attributes(name: '') }

      it '名前が入力されていない場合は無効' do
        expect(user).to be_invalid
      end
    end
  end
end
