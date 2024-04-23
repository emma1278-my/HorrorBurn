class Profile < ApplicationRecord
  belongs_to :user, dependent: :destroy

 
  has_one :movie_weight_loss_goal
  accepts_nested_attributes_for :movie_weight_loss_goal

end
