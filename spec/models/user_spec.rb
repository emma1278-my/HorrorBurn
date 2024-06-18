# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it '名前とメールアドレスとパスワードがあれば登録できる' do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it '名前がなければ登録できない' do
    user = FactoryBot.build(:user, name: nil)
    expect(user).not_to be_valid
    expect(user.errors.full_messages).to include('名前を入力してください')
  end

  it 'メールアドレスがなければ登録できない' do
    expect(FactoryBot.build(:user, email: '')).to be_invalid
  end

  it "パスワードがなければ登録できない" do
    expect(FactoryBot.build(:user, password: '')).to be_invalid
  end

  it 'パスワード確認がなければ登録できない' do
    expect(FactoryBot.build(:user, password_confirmation: '')).to be_invalid
  end

  it "パスワードとパスワード確認が一致しなければ登録できない" do
    expect(FactoryBot.build(:user, password_confirmation: 'password_confirmation')).to be_invalid
  end

  it '名前が255文字以上' do
    user = FactoryBot.build(:user, name: 'A' * 256)
    expect(user).not_to be_valid
    expect(user.errors.full_messages).to include('名前は255文字までにしてください')
  end

  it 'パスワードが3文字以内' do
    user = FactoryBot.build(:user, password: 'A1')
    expect(user).not_to be_valid
    expect(user.errors.full_messages).to include('パスワードは3文字以上で入力してください')
  end

  it 'is invalid if the password confirmation is not entered' do
    user = FactoryBot.build(:user, password_confirmation: nil)
    expect(user).not_to be_valid
    expect(user.errors.full_messages).to include('パスワード確認を入力してください')
  end
end