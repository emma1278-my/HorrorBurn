class WeightLogsController < ApplicationController
  before_action :set_weight_log, only: %i[ show edit update destroy ]
  
  def new
    @weight_log = WeightLog.new
  end

  def show
    @weight_logs = WeightLog.all
    base_days = [*Date.current - 1.week .. Date.current]  # 日付データの配列を生成
    base_days.each do |base_day|
      # 1日の投稿数を取得
      day_count = Weight.where(user_id: current_user.id).where(created_at: base_day.beginning_of_day...base_day.end_of_day).count
      # 取得した投稿数を配列としてチャート用のインスタンス変数に日付とともに代入
      @weight_logs << [base_day.strftime('%Y/%m/%d').to_s, day_count]
    end
  end

  def edit
  end

  def create
    @weight_log = current_user.weight_logs.new(weight_params)
    if @weight_log.save
      flash[:success] = t(".save_weight_log")
    else
      flash[:alert] = t(".not_save_weight_log")
    end
    redirect_to dashboard_path(id: current_user.id)
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
    params.require(:weight_log).permit(:weight, :date).merge(user_id: current_user.id)
  end
end
