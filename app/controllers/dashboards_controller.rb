class DashboardsController < ApplicationController
  before_action :require_login
  before_action :check_guest_user

  def show
    @user = current_user
    @profile = @user.profile
    @weight_logs = @user.weight_logs.order(created_at: :asc).pluck(:created_at, :weight)
    @movie_histories = current_user.movie_histories
    @latest_weight_log = @user.weight_logs.order(created_at: :desc).first
    @total_watched_runtime = current_user.movie_histories.sum(:runtime)
    if @latest_weight_log.present? && @user.profile.present?
      current_weight = @latest_weight_log.weight
      session[:target_weight] = target_weight
      target_weight = session[:target_weight].to_f
      @remaining_weight = current_weight - target_weight
    end
  end
 
    private

  def check_guest_user
    if current_user.email.end_with?('@example.com')
      flash[:alert] = t('dashboards.check_guest_user.trial')
      redirect_to new_user_path
    end
  end
end
