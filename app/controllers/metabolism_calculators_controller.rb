class MetabolismCalculatorsController < ApplicationController
  skip_before_action :require_login, only: [:new, :show, :create, :destroy]
  
  def new; end

  def calculate_weight_difference
    weight = params[:weight].to_f
    target_weight = params[:target_weight].to_f
    @weight_difference = weight - target_weight
  end

  def create
    # フォームから送信されたパラメータを受け取る
    weight = params[:weight].to_f

    # ホラー映画視聴で消費するための総時間の計算
    total_movie_runtime = total_movie_runtime_needed_for_movies(total_calories)
    # 計算結果をビューに渡す
    @results = {
      bmr: bmr,
      total_calories: total_calories,
      total_movie_runtime: total_movie_runtime
    }
     
  if movie_weight_loss_goal.save
    redirect_to show_metabolism_calculators_path
  else
    flash.now[:alert] = t(".alert")
      render :new, status: :unprocessable_entity
    end 
  end

  

  # 計算結果のやり直し
  def destroy
    session.delete(:result)
    redirect_to new_metabolism_calculators_path
  end

  private

  def profile_params
    params.require(:profile).permit(:weight)
  end

  def movie_weight_loss_goal_params
    params.require(:movie_weight_loss_goal).permit(:weight, :weight_achieved_date)
  end
end

