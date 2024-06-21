# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  
  describe 'バリデーション' do
    context '有効な場合' do
      it '名前とメールアドレスとパスワードがあれば登録できる' do
        expect(user).to be_valid
      end
    end

    context '無効な場合' do
      it '名前がなければ登録できない' do
        user.name = nil
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include('名前を入力してください')
      end

      it 'メールアドレスがなければ登録できない' do
        user.email = ''
        expect(user).to be_invalid
      end

      it 'パスワードがなければ登録できない' do
        user.password = ''
        expect(user).to be_invalid
      end

      it 'パスワード確認がなければ登録できない' do
        user.password_confirmation = ''
        expect(user).to be_invalid
      end

      it 'パスワードとパスワード確認が一致しなければ登録できない' do
        user.password_confirmation = 'password_confirmation'
        expect(user).to be_invalid
      end

      it '名前が255文字以上' do
        user.name = 'A' * 256
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include('名前は255文字以内で入力してください')
      end

      it 'パスワードが3文字以内' do
        user.password = 'A1'
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include('パスワードは3文字以上で入力してください')
      end
    end
  end
end