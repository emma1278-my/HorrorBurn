class WeightLog < ApplicationRecord
  belongs_to :user, dependent: :destroy
  validates :weight, presence: true
  
  def self.weight_log_for_day(user)
    user.weight_logs.find_by(created_at: Time.zone.now.all_day)
  end
end
