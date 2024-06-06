require 'rails_helper'

RSpec.describe Movie, type: :model do
  let(:user) { create(:user, target_calorie: 10_000) }
  let(:movie) { create(:movie, title: 'Test Movie', runtime: 120) }
  let(:valid_params) do
    {
      movie_history: {
        movie_id: movie.id,
        title: movie.title,
        runtime: movie.runtime
      }
    }
  end

  before do
    sign_in user
    allow(Net::HTTP).to receive(:get).and_return(movie.to_json)
  end

  describe 'Associations' do
    it 'belongs to a user' do
      should belong_to(:user)
    end
  end

  describe 'Check Validations' do
    it 'is valid with valid attributes' do
      expect(movie).to be_valid
    end

    it 'is not valid without a title' do
      movie.title = nil
      expect(movie).not_to be_valid
    end
  end

  describe 'POST /movie_histories' do
    context 'with valid params' do
      it 'creates a new movie history and updates user data' do
        expect do
          post movie_histories_path, params: valid_params
        end.to change(MovieHistory, :count).by(1)
        expect(response).to redirect_to(dashboard_path(user))
        follow_redirect!
        expect(response.body).to include(I18n.t('movie_histories.create.success'))
      end

      context 'when user has no target_calorie' do
        before do
          user.update(target_calorie: nil)
        end

        it 'does not create a new movie history and redirects to the dashboard with reminder alert' do
          expect do
            post movie_histories_path, params: valid_params
          end.not_to change(MovieHistory, :count)
          expect(response).to redirect_to(dashboard_path(user))
          follow_redirect!
          expect(response.body).to include(I18n.t('movie_histories.create.remind_calculator'))
        end
      end
    end
  end

  describe 'GET /movies_search' do
    it 'returns the search results' do
      get movies_search_path, params: { looking_for: 'Test Movie' }
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Test Movie')
    end
  end

  describe 'GET /show' do
    it 'returns movie details' do
      get movie_path(movie.id)
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Test Movie')
    end
  end
end
