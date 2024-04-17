class DashboardsController < ApplicationController

  def show
    @user = current_user # 現在ログインしているユーザーを取得
    @weight_logs = current_user.weight_logs.order(created_at: :asc)
  end
end
