class DashboardsController < ApplicationController

  def index; end


  def show
    @user = current_user # 現在ログインしているユーザーを取得
   # @weight_loss_goals = @user.movie_weight_loss_goals
  #  @weight_logs = @user.weight_logs
  end
end
