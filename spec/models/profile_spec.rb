# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'バリデーション' do
    context '有効な場合' do
      let(:valid_attributes) { { name: '新しい名前' } }

      it '有効である' do
        expect(user).to be_valid
      end
    end

    context '無効な場合' do
      let(:invalid_attributes) { { name: '' } }
      it '名前が入力されていない場合は無効' do
        user.assign_attributes(invalid_attributes)
        expect(user).to be_invalid
      end
    end
  end

  describe 'プロフィール更新' do
    context '有効な属性の場合' do
      let(:valid_attributes) { { name: '新しい名前' } }

      it 'ユーザープロフィールを更新する' do
        user.update_profile(valid_attributes)
        expect(user.name).to eq('新しい名前')
      end
    end

    context '無効な場合' do
      let(:invalid_attributes) { { name: '' } }

      it 'ユーザープロフィールを更新しない' do
        user.update_profile(invalid_attributes)
        expect(user.name).not_to be_empty
      end
    end
  end
end