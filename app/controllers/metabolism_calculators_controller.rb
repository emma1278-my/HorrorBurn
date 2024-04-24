class MetabolismCalculatorsController < ApplicationController
  skip_before_action :require_login, only: [:new, :show, :create, :destroy]
  
  def new; end

  def calculate_weight_difference
    weight = params[:weight].to_f
    target_weight = params[:target_weight].to_f
    @weight_difference = weight - target_weight
  end

  def create
    # フォームから送られてきたデータ
    current_weight = params[:current_weight].to_f
    target_weight = params[:target_weight].to_f
    @remaining_weight = current_weight - target_weight
    # 計算式
    calories_per_movie = 113 # 90分のホラー映画で消費されるカロリー
    movie_duration = 90 # ホラー映画の時間（分）
    @target_calorie = (current_weight - target_weight) * 7200
    # 必要なホラー映画視聴時間を計算
    @remaining_runtime = (@target_calorie / 113.0) * movie_duration
    session[:remaining_weight] = @remaining_weight
    session[:target_calorie] = @target_calorie
    session[:remaining_runtime] = @remaining_runtime
    # 計算結果をビューに渡す
    render :show, notice: '計算完了！'
  end


  # 計算結果のやり直し
  def destroy
    session.delete(:remaining_weight)
    session.delete(:target_calorie)
    session.delete(:remaining_runtime)
   
    redirect_to new_metabolism_calculators_path
  end

  private

  def profile_params
    params.require(:profile).permit(:weight, :weight_achieved_date)
  end
end

