class DashboardsController < ApplicationController

  def show
    @user = current_user # 現在ログインしているユーザーを取得
   # @weight_loss_goals = @user.movie_weight_loss_goals
    @weight_logs = WeightLog.all
    @today_weight_log = WeightLog.weight_log_for_day(current_user)
    @weight_logs = current_user.weight_logs.order(created_at: :asc).pluck(:created_at, :weight)
  end
end
