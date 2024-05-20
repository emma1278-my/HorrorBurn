class MetabolismCalculatorsController < ApplicationController
  skip_before_action :require_login, only: [:new, :show, :create, :destroy]
  
  def new; end

  def create
    # フォームから送られてきたデータ
    current_weight = params[:current_weight].to_f
    target_weight = params[:target_weight].to_f
    remaining_weight = current_weight - target_weight
    # 計算式
    calories_per_movie = 113 # 90分のホラー映画で消費されるカロリー
    movie_duration = 90 # ホラー映画の時間(分)
    target_calorie = (current_weight - target_weight) * 7200  #脂肪1kgあたりに必要な消費カロリー
    # 必要なホラー映画視聴時間を計算
    remaining_runtime = (target_calorie / 113.0) * movie_duration / 60.0 # ホラー映画の時間(h)

    # 現在のユーザーのデータを更新する
    current_user.update(
      current_weight: current_weight,
      target_weight: target_weight,
      remaining_weight: remaining_weight,
      target_calorie: target_calorie,
      remaining_runtime: remaining_runtime
    )

    @remaining_weight = remaining_weight
    @target_calorie = target_calorie
    @remaining_runtime = remaining_runtime

    render :show
  end

  # 計算結果やり直し
  def destroy
    current_user.update(
      current_weight: nil,
      target_weight: nil,
      remaining_weight: nil,
      target_calorie: nil,
      remaining_runtime: nil
    )
    redirect_to new_metabolism_calculators_path
  end


  private

  def profile_params
    params.require(:profile).permit(:weight, :weight_achieved_date, :target_weight)
  end
end

