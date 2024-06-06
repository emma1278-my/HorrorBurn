# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MovieHistory, type: :model do
  let(:user) { create(:user) }
  let(:movie) { create(:movie) }
  let(:valid_params) { { movie_history: { movie_id: movie.id, title: movie.title, runtime: movie.runtime } } }
  describe 'When user saved movie history' do
    context 'when user is logged in' do
      context 'with valid params' do
        let(:valid_params) { { movie_history: { movie_id: movie.id, title: movie.title, runtime: movie.runtime } } }

        it 'creates a new movie history' do
          expect do
            post movie_histories_path, params: valid_params
          end.to change(MovieHistory, :count).by(1)
        end

        it 'updates remaining runtime' do
          expect { post :create, params: valid_params }.to(change { remaining_runtime })
        end

        it 'redirects to dashboard_path' do
          post :create, params: valid_params
          expect(response).to redirect_to(dashboard_path(user))
        end
      end

      context 'with invalid params' do
        let(:invalid_params) { { movie_history: { movie_id: nil, title: nil, runtime: nil } } }

        it 'does not create a new movie history' do
          expect { post :create, params: invalid_params }.not_to change(MovieHistory, :count)
        end

        it 'redirects to movies_search_path' do
          post :create, params: invalid_params
          expect(response).to redirect_to(movies_search_path)
        end
      end

      context 'when target_calorie is not present' do
        before { user.update(target_calorie: nil) }

        it 'redirects to dashboard_path' do
          post :create, params: { movie_history: { movie_id: movie.id, title: movie.title, runtime: movie.runtime } }
          expect(response).to redirect_to(dashboard_path(user))
        end
      end
    end

    context 'when user is not logged in' do
      it 'redirects to login page' do
        post :create, params: { movie_history: { movie_id: movie.id, title: movie.title, runtime: movie.runtime } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'When user deleted a movie history' do
    let(:movie_history) { create(:movie_history, user:, movie:) }

    context 'when user is logged in' do
      it 'destroys the movie history' do
        expect { delete :destroy, params: { id: movie_history.id } }.to change(MovieHistory, :count).by(-1)
      end

      it 'updates remaining runtime' do
        expect { delete :destroy, params: { id: movie_history.id } }.to(change { user.reload.remaining_runtime })
      end

      it 'redirects to dashboard_path' do
        delete :destroy, params: { id: movie_history.id }
        expect(response).to redirect_to(dashboard_path(user))
      end
    end

    context 'when user is not logged in' do
      it 'redirects to login page' do
        delete :destroy, params: { id: movie_history.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
