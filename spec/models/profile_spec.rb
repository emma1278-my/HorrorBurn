# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Profile, type: :model do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'Transition to editing screen' do
    it 'returns http success' do
      get :edit, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:valid_attributes) { { name: 'New Name' } }

      it 'updates the requested user' do
        put :update, params: { id: user.id, user: valid_attributes }
        user.reload
        expect(user.name).to eq('New Name')
      end

      it 'redirects to the profile page' do
        put :update, params: { id: user.id, user: valid_attributes }
        expect(response).to redirect_to(profile_path)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { { name: '' } }

      it 'returns unprocessable_entity status' do
        put :update, params: { id: user.id, user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when the user is a guest' do
      let(:user) { build_stubbed(:user, guest: true) }

      it 'renders the guest avatar image' do
        render
        expect(rendered).to have_css('img[src*="guset.png"]')
      end

      it 'does not render the edit profile link' do
        render
        expect(rendered).not_to have_link(I18n.t('defaults.edit'), href: edit_profile_path)
      end

      it 'does not render the reset password link' do
        render
        expect(rendered).not_to have_link(I18n.t('.reset_password'), href: new_password_reset_path)
      end

      context 'when the user is not a guest' do
        let(:user) { build_stubbed(:user, guest: false) }

        it 'renders the user avatar image' do
          render
          expect(rendered).to have_css("img[src='#{user.avatar_url}']")
        end

        it 'renders the edit profile link' do
          render
          expect(rendered).to have_link(I18n.t('defaults.edit'), href: edit_profile_path)
        end

        it 'renders the reset password link' do
          render
          expect(rendered).to have_link(I18n.t('.reset_password'), href: new_password_reset_path)
        end

        it 'renders the delete account link' do
          render
          expect(rendered).to have_link(I18n.t('.delete_account'), href: user_path(user))
        end
      end
    end
  end
end
