class MetabolismCalculatorsController < ApplicationController
  skip_before_action :require_login, only: [:new, :show]
  
  def new
    @profile = Profile.new
    @movie_weight_loss_goal = MovieWeightLossGoal.new
  end

  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      @movie_weight_loss_goal = @profile.build_weight_loss_goal(movie_weight_loss_goal_params)
      if @movie_weight_loss_goal.save
        # 基礎代謝を算出する処理をここに記述
        redirect_to new_metabolism_calculators_path
      else
        lash.now[:alert] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end
end

  def calculate
    # calculate_bmr methodを呼び出し、結果を取得
    result = calculate_bmr(params[:gender], params[:weight].to_f, params[:height].to_f, params[:age].to_i)
    session[:result] = result
    # 計算結果をweight_loss_goalsテーブルに保存
    movie_weight_loss_goal = MovieWeightLossGoal.new(result: result)
    if movie_weight_loss_goal.save
      # 保存に成功、結果を表示するためのshowページへリダイレクト
      redirect_to show_metabolism_calculators_path
    else
      flash.now[:alert] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def calculate_bmr(gender, weight, height, age)
    if gender == 'male'
      13.397 * weight + 4.799 * height - 5.677 * age + 88.362
    elsif gender == 'female'
      9.247 * weight + 3.098 * height - 4.33 * age + 447.593
    end
  end

   # 基礎代謝(BMR)を計算
   def calculate_bmr
    if self.gender == '男性'
      bmr = (10 * self.weight) + (6.25 * self.height) - (5 * self.age) + 5
    else
      bmr = (10 * self.weight) + (6.25 * self.height) - (5 * self.age) - 161
    end
    bmr
  end

  # 1日の消費カロリーを計算
  def calculate_daily_calories(mets, movie_watching_hours)
    bmr = calculate_bmr
    pal = 1.2 # Sedentary（ほとんど運動しない）の場合
    total_calories_needed = bmr * pal
    daily_calories = total_calories_needed + (mets * self.weight * movie_watching_hours * 1.05)
    daily_calories
  end

 # 計算結果を取得
  def show
    result = session[:result]
    @movie_weight_loss_goal = MovieWeightLossGoal.find(params[:id])
    @movie_weight_loss_goal.calculate_bmr
    # METsと映画視聴時間は固定値を使用
    @movie_weight_loss_goal.calculate_daily_calories(1.5, 2)
  end
  

  # 計算結果のやり直し
  def destroy
    session.delete(:result)
    redirect_to new_metabolism_calculators_path
  end

  private

  def profile_params
    params.require(:profile).permit(:gender, :age, :height)
  end

  def movie_weight_loss_goal_params
    params.require(:movie_weight_loss_goal).permit(:weight, :weight_achieved_date)
  end
end