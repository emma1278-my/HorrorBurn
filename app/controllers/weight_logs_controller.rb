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
   # 目標体重
    target_weight = current_user.target_weight
      flash[:success] = t(".save_weight_log")
  # 最新の体重
    latest_weight = @weight_log.weight
    # 目標体重までの残り
    remaining_weight = target_weight - latest_weight
    # 残りの体重を保存
    session[:remaining_weight] = remaining_weight
    else
      flash[:alert] = t(".not_save_weight_log")
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
