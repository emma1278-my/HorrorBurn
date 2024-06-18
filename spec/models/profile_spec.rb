# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Profile, type: :model do
  let(:user) { FactoryBot.create(:user) }

  describe '編集画面への遷移' do
    it 'HTTPステータスが成功となる' do
      get :edit, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe '更新を押す' do
    context '有効なパラメータの場合' do
      let(:valid_attributes) { { name: '新しい名前' } }

      it 'ユーザー情報が更新される' do
        put :update, params: { id: user.id, user: valid_attributes }
        user.reload
        expect(user.name).to eq('新しい名前')
      end

      it 'プロフィールページにリダイレクトする' do
        put :update, params: { id: user.id, user: valid_attributes }
        expect(response).to redirect_to(profile_path)
      end
    end

    context '無効なパラメータの場合' do
      let(:invalid_attributes) { { name: '' } }

      it '処理できないエンティティのステータスを返す' do
        put :update, params: { id: user.id, user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'ユーザーがゲストの場合' do
      let(:user) { build_stubbed(:user, guest: true) }

      it 'ゲストのアバター画像がレンダリングされる' do
        render
        expect(rendered).to have_css('img[src*="guset.png"]')
      end

      it 'プロフィール編集リンクがレンダリングされない' do
        render
        expect(rendered).not_to have_link(I18n.t('defaults.edit'), href: edit_profile_path)
      end

      it 'パスワードリセットリンクがレンダリングされない' do
        render
        expect(rendered).not_to have_link(I18n.t('.reset_password'), href: new_password_reset_path)
      end

      context 'ユーザーがゲストでない場合' do
        let(:user) { build_stubbed(:user, guest: false) }

        it 'プロフィール編集リンクがレンダリングされる' do
          render
          expect(rendered).to have_link(I18n.t('defaults.edit'), href: edit_profile_path)
        end

        it 'パスワードリセットリンクがレンダリングされる' do
          render
          expect(rendered).to have_link(I18n.t('.reset_password'), href: new_password_reset_path)
        end

        it 'アカウント削除リンクがレンダリングされる' do
          render
          expect(rendered).to have_link(I18n.t('.delete_account'), href: user_path(user))
        end
      end
    end
  end
end