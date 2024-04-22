class MovieWeightLossGoal < ApplicationRecord
  belongs_to :user

  def show
    @movie_weight_loss_goal = MovieWeightLossGoals.find(params[:id])
    user = @movie_weight_loss_goal.user
    @basal_metabolic_rate = user.calculate_bmr
    # 1日の消費カロリは、必要なパラメータに応じて呼び出す
    @daily_calorie_consumption = user.calculate_daily_calories(mets, movie_runtime)
  end

  def total_runtime(target_calories)
    runtime_count = target_calories.to_f / 113
    total_time = runtime_count * 90
    total_time
  end
end