class Profile < ApplicationRecord
  belongs_to :user, dependent: :destroy

  enum gender: { male: 0, female: 1}
  has_one :movie_weight_loss_goal
  accepts_nested_attributes_for :movie_weight_loss_goal
end
