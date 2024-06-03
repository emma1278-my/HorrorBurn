require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションチェック' do
    context '有効' do
      it '必要な情報が全て入力されている場合は成功' do
        user = FactoryBot.build(:user)
        expect(user).to be_valid
      end
    end

    context '無効' do
      it '名前が入力されていない場合は無効' do
        user = FactoryBot.build(:user, name: nil)
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include("名前を入力してください")
      end

      it "メールアドレスがなければ登録できない" do
        expect(FactoryBot.build(:user, email: "")).to be_invalid
      end

      it "メールアドレスが重複していたら登録できない" do
        user = FactoryBot.create(:user)
        expect(FactoryBot.build(:user, email: user.email)).to be_invalid
      end

      it "パスワードがなければ登録できない" do
        expect(FactoryBot.build(:user, password: "")).to be_invalid
      end

      it "パスワード確認がなければ登録できない" do
        expect(FactoryBot.build(:user, password_confirmation: "")).to be_invalid
      end

      it "パスワードとパスワード確認が一致しなければ登録できない" do
        expect(FactoryBot.build(:user, password_confirmation: "password_confirmation")).to be_invalid
      end
    
      it '名前が255文字を超える場合は無効' do
        user = FactoryBot.build(:user, name: 'A' * 256)
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include("名前は255文字以内で入力してください")
      end

      it 'メールアドレスが入力されていない場合は無効' do
        user = FactoryBot.build(:user, email: nil)
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include("メールアドレスを入力してください")
      end

      it '重複したメールアドレスの場合は無効' do
        FactoryBot.create(:user)
        user = FactoryBot.build(:user, email: 'test@example.com')
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include("メールアドレスはすでに存在します")
      end

      it 'パスワードが3文字以下の場合は無効' do
        user = FactoryBot.build(:user, password: 'A1')
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include("パスワードは3文字以上で入力してください")
      end

      it '確認用パスワードが入力されていない場合は無効' do
        user = FactoryBot.build(:user, password_confirmation: nil)
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include("確認用パスワードを入力してください")
      end
    end

    context '外部プロバイダー関連' do
      it 'プロバイダー名"google"の確認が出来ているか' do
        expect(user.google_check).to eq true
      end
    end
  end
end

  
 
