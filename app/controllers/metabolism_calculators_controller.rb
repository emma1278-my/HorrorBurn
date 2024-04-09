class MetabolismCalculatorsController < ApplicationController
  skip_before_action :require_login, only: [:new, :show]
  
  def calculate
    # calculate_bmr methodを呼び出し、結果を取得
    result = calculate_bmr(params[:gender], params[:weight].to_f, params[:height].to_f, params[:age].to_i)
    session[:result] = result

    # 計算結果をweight_loss_goalsテーブルに保存
    movie_weight_loss_goal = MovieWeightLossGoal.new(result: result)
    if movie_weight_loss_goal.save
      # 保存に成功、結果を表示するためのshowページへリダイレクト
      redirect_to new_metabolism_calculators_path
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

  def show
    # 計算結果を取得
    @result = session[:result]
  end

  # 計算結果のやり直し  
  def destroy 
    session.delete(:result)
    # ここにリダイレクトなどの処理を書く
  end
end