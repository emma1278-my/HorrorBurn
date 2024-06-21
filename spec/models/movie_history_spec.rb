# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MovieHistory, type: :model do
  let(:user) { create(:user) }
  let(:movie) { create(:movie) }
  let(:valid_params) { { movie_history: { movie_id: movie.id, title: movie.title, runtime: movie.runtime } } }
  let(:valid_attributes) { { movie_id: movie.id, title: movie.title, runtime: movie.runtime, user: user } }
  let(:invalid_attributes) { { movie_id: nil, title: nil, runtime: nil, user: user } }

  describe '映画視聴履歴を追加' do
    it '映画視聴履歴を記録' do
      expect { MovieHistory.create!(valid_attributes) }.to change(MovieHistory, :count).by(1)
    end

    context '無効' do
      it '映画視聴履歴を作成できない' do
        expect { MovieHistory.create!(invalid_attributes) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe '映画視聴履歴を削除' do
    let(:movie_history) { create(:movie_history, user: user, movie: movie) }

    it '映画視聴履歴がマイページから消える' do
      expect { movie_history.destroy }.to change(MovieHistory, :count).by(-1)
    end

    it '残りの目標映画視聴時間が更新' do
      expect { movie_history.destroy }.to change { user.reload.remaining_runtime }
    end
  end
end