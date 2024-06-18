# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MovieHistory, type: :model do
  let(:user) { create(:user) }
  let(:movie) { create(:movie) }
  let(:valid_params) { { movie_history: { movie_id: movie.id, title: movie.title, runtime: movie.runtime } } }
  describe '映画視聴履歴を追加' do
    context 'ユーザーがゲストではない場合' do
      context '有効' do
        let(:valid_params) { { movie_history: { movie_id: movie.id, title: movie.title, runtime: movie.runtime } } }

        it '映画視聴履歴を記録' do
          expect do
            create movie_histories_path, params: valid_params
          end.to change(MovieHistory, :count).by(1)
        end

        it 'マイページにもどる' do
          post :create, params: valid_params
          expect(response).to redirect_to(dashboard_path(user))
        end
      end

      context '無効' do
        let(:invalid_params) { { movie_history: { movie_id: nil, title: nil, runtime: nil } } }

        it '映画検索ページに遷移' do
          post :create, params: invalid_params
          expect(response).to redirect_to(movies_search_path)
        end
      end

  describe '映画視聴履歴を削除' do
    let(:movie_history) { create(:movie_history, user:, movie:) }
      it 'マイページから消える' do
        expect { delete :destroy, params: { id: movie_history.id } }.to change(MovieHistory, :count).by(-1)
      end

      it '残りの目標映画視聴時間が更新' do
        expect { delete :destroy, params: { id: movie_history.id } }.to(change { user.reload.remaining_runtime })
      end

      it 'マイページにとどまる' do
        delete :destroy, params: { id: movie_history.id }
        expect(response).to redirect_to(dashboard_path(user))
      end
    end
  end
end
