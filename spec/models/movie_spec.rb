require 'rails_helper'

RSpec.describe Movie, type: :model do
  let(:movie) { build(:movie, title: 'テスト映画', runtime: 120) }
  
  describe 'バリデーション' do
    it '有効' do
      expect(movie).to be_valid
    end

    it '映画のタイトルがないと無効' do
      movie.title = nil
      expect(movie).not_to be_valid
    end
  end
end