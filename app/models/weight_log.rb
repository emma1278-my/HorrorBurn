class WeightLog < ApplicationRecord
  belongs_to :user, dependent: :destroy
  validates :weight, presence: true
  after_save :adjust_target_weight

  def self.weight_log_for_day(user)
    user.weight_logs.find_by(created_at: Time.zone.now.all_day)
  end

  private

  def adjust_target_weight
    # ここに目標体重を調整するロジックを書く
    # 例: 最新の体重が目標体重より2kg減った場合、新しい目標体重を設定
    if user.target_weight && weight < user.target_weight - 2
      new_target = weight + 2 # 新しい目標を現在の体重+2kgに設定
      user.update(target_weight: new_target)
    end
  end
end
