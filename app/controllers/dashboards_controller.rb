class DashboardsController < ApplicationController
  before_action :require_login
  before_action :check_guest_user, only: [:dashboard]

  def show
    @user = current_user
    @profile = @user.profile
    @weight_logs = @user.weight_logs.order(created_at: :asc).pluck(:created_at, :weight)
    @latest_weight_log = @user.weight_logs.order(created_at: :desc).first
 
    if @latest_weight_log.present? && @user.profile.present?
      current_weight = @latest_weight_log.weight
      target_weight = @user.profile.target_weight
      @remaining_weight = current_weight - target_weight
    end
  end

    private

  def check_guest_user
    if current_user.email.end_with?('@example.com')
      flash[:alert] = 'マイページを使用するためには本登録してください'
      redirect_to new_user_path
    end
  end
end
