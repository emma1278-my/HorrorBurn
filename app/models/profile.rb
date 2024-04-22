class Profile < ApplicationRecord
  belongs_to :user, dependent: :destroy

  enum gender: { male: 0, female: 1}
 # user = User.new(gender: params[:gender])
  has_one :movie_weight_loss_goal
  accepts_nested_attributes_for :movie_weight_loss_goal

   # BMRを計算するメソッド
   def calculate_bmr
    gender_index = self.gender == "male" ? 0.5473 : (0.5473 * 2)
    ((0.1238 + (0.0481 * self.weight) + (0.0234 * self.height) - (0.0138 * self.age) - gender) * 1000) / 4.186
  end
end
