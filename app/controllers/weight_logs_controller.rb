class WeightLogsController < ApplicationController
  before_action :set_weight_log, only: %i[ show edit update destroy ]
  
  def new
    @weight_log = WeightLog.new
  end

  def show
    @weight_logs = WeightLog.all
  end

  def edit
  end

  def create
    @weight_log = current_user.weight_logs.new(weight_params)
    if @weight_log.save    
      flash[:success] = t(".success")
      # 最新の体重
      latest_weight = @weight_log.weight
      # 目標体重までの残り
      target_weight = session[:target_weight]
      @remaining_weight = latest_weight - target_weight
      # 目標体重に到達したかチェック
    if @remaining_weight <= 0
      flash[:success] = t(".next_weight_log")
    end
    redirect_to dashboard_path(id: current_user.id)
  else
    flash[:alert] = t(".failure")
    redirect_to dashboard_path(id: current_user.id)
  end
end
   

  def update
    if @weight_log.update(weight_params)
      flash[:success] = t(".update_weight_log")
      redirect_to users_profiles_path
    else
      flash[:alert] = t(".not_update_weight_log")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @weight_log.destroy
  end

  private

  def set_weight_log
    @weight_log = current_user.weight_logs.find(params[:id])
  end

  def weight_params
    params.require(:weight_log).permit(:weight)
  end
end
