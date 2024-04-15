class MetabolismCalculatorsController < ApplicationController
  skip_before_action :require_login, only: [:new, :show, :create, :destroy]
  
  def new
    @movie_weight_loss_goal = MovieWeightLossGoal.new
  end

  def create
    @movie_weight_loss_goal = MovieWeightLossGoal.new(movie_weight_loss_goal_params)
      if @movie_weight_loss_goal.save
        # 保存成功時の処理
        redirect_to new_metabolism_calculators_path
      else
        # 保存失敗時の処理
        render :new
    end
  end

 # 計算結果を取得
  def show
  @movie_weight_loss_goal = MovieWeightLossGoal.find(params[:id])
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

