class WeightLogsController < ApplicationController
  before_action :set_weight_log, only: %i[update]

  def create
    @weight_log = current_user.weight_logs.new(weight_params)
    if @weight_log.save
      flash[:success] = t(".save_weight_log")
    else
      flash[:alert] = t(".not_save_weight_log")
    end
    redirect_to users_profiles_path
  end

  def update
    if @weight_log.update(weight_params)
      flash[:success] = t(".update_weight_log")
      redirect_to users_profiles_path
    else
      flash[:alert] = t(".not_update_weight_log")
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_weight_log
    @weight_log = current_user.weight_logs.find(params[:id])
  end

  def weight_params
    params.require(:weight_log).permit(:weight)
  end
end
