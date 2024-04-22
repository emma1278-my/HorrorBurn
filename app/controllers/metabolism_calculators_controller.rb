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
    height = params[:height].to_f
    age = params[:age].to_i
    gender = params[:gender]
    # 性別に応じた性別指数の設定
    gender = user.male? ? 0.5473 : (0.5473 * 2)
    # BMRの計算
    bmr = calculate_bmr(weight, height, age, gender)
    # 目標までの総消費カロリーの算出
    total_calories = total_calories_needed(bmr)
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
  
  # ここに先ほどの計算メソッドを定義する
  def calculate_bmr(weight, height, age, gender)
    ((0.1238 + (0.0481 * weight) + (0.0234 * height) - (0.0138 * age) - gender) * 1000) / 4.186
  end

  def total_calories_needed(bmr)
    bmr * 1.2
  end

  def total_hours_needed_for_movies(total_calories)
     # ホラー映画を観て消費されるカロリーで割る
  movie_sessions_needed = total_calories / 113.0 
  # 必要なホラー映画視聴回数に90分を乗じて総視聴時間を求める
  movie_sessions_needed * 90 
  end

  def profile_params
    params.require(:profile).permit(:gender, :age, :height)
  end

  def movie_weight_loss_goal_params
    params.require(:movie_weight_loss_goal).permit(:weight, :weight_achieved_date)
  end
end

