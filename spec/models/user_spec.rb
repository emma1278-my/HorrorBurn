# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  describe 'Validation checks' do
    context 'Valid' do
      it 'succeeds when all necessary information is entered' do
        user = FactoryBot.build(:user)
        expect(user).to be_valid
      end
    end

    context 'invalid' do
      it 'is invalid when the name is not entered' do
        user = FactoryBot.build(:user, name: nil)
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include('Please enter your email address')
      end

      it 'is invalid when the email address is duplicated' do
        expect(FactoryBot.build(:user, email: '')).to be_invalid
      end

      it 'is invalid when the email address is not entered' do
        user = FactoryBot.create(:user)
        expect(FactoryBot.build(:user, email: user.email)).to be_invalid
      end

      it 'is invalid When the password is not entered' do
        expect(FactoryBot.build(:user, password: '')).to be_invalid
      end

      it 'is invalid When the password confirmation is not entered' do
        expect(FactoryBot.build(:user, password_confirmation: '')).to be_invalid
      end

      it 'is invalid when the password and password confirmation do not match' do
        expect(FactoryBot.build(:user, password_confirmation: 'password_confirmation')).to be_invalid
      end

      it 'is invalid if the name exceeds 255 characters' do
        user = FactoryBot.build(:user, name: 'A' * 256)
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include('Name must be within 255 characters')
      end

      it 'is invalid if the email address is not entered' do
        user = FactoryBot.build(:user, email: nil)
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include('Email must be entered')
      end

      it 'is invalid when the email address is duplicated' do
        FactoryBot.create(:user)
        user = FactoryBot.build(:user, email: 'test@example.com')
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include('Email alredy exists')
      end

      it 'is invalid if the password is within 3 charactors' do
        user = FactoryBot.build(:user, password: 'A1')
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include('Password must be 3 or more characters long')
      end

      it 'is invalid if the password confirmation is not entered' do
        user = FactoryBot.build(:user, password_confirmation: nil)
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include('Password confirmation must be entered')
      end
    end

    context 'checks if the provider name "google" can be confirmed' do
      it 'checks if the provider name "google" can be confirmed' do
        expect(user.google_check).to eq true
      end
    end
  end
end
