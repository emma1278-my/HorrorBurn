# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:user) { create(:user, target_calorie: 10_000) }
  let(:movie) { create(:movie, title: 'テスト映画', runtime: 120) }
  let(:valid_params) do
    {
      movie_history: {
        movie_id: movie.id,
        title: movie.title,
        runtime: movie.runtime
      }
    }
  end

  describe 'アソシエーション' do
    it 'Userと関連付けされている' do
      should belong_to(:user)
    end
  end

  describe 'バリデーション' do
    it '有効' do
      expect(movie).to be_valid
    end

    it '映画のタイトルがない' do
      movie.title = nil
      expect(movie).not_to be_valid
    end
  end

  describe '映画視聴履歴を追加' do
    context '有効' do
      it '視聴履歴がマイページに追加される' do
        expect do
          post movie_histories_path, params: valid_params
        end.to change(MovieHistory, :count).by(1)
        expect(response).to redirect_to(dashboard_path(user))
        follow_redirect!
        expect(response.body).to include(I18n.t('movie_histories.create.success'))
      end
    end
  end

  describe '映画検索' do
    it '検索結果に映画が表示される' do
      get movies_search_path, params: { looking_for: 'テスト映画' }
      expect(response).to have_http_status(:success)
      expect(response.body).to include('テスト映画')
    end
  end

  describe '映画検索で得た映画情報を選択' do
    it '映画詳細ページ遷移' do
      get movie_path(movie.id)
      expect(response).to have_http_status(:success)
      expect(response.body).to include('テスト映画')
    end
  end
end
