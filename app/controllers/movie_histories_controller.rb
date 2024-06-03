class MovieHistoriesController < ApplicationController
  def create
    @movie_history = current_user.movie_histories.build(movie_history_params)
    if current_user.target_calorie.present?
      if @movie_history.save
        update_remaining_runtime
        redirect_to dashboard_path(current_user), notice: t('movie_histories.create.success')
      else
        redirect_to movies_search_path, alert: t('movie_histories.create.failure')
      end
    else
      redirect_to dashboard_path(current_user), alert: t('movie_histories.create.remind_calculator')
    end
  end

  def destroy
    @movie_history = current_user.movie_histories.find(params[:id])
    @movie_history.destroy
    update_remaining_runtime
    redirect_to dashboard_path(current_user), notice: t('.destroy.success')
  end
end

  private

def movie_history_params
  params.require(:movie_history).permit(:movie_id, :title, :runtime)
end

def update_remaining_runtime(deleted_runtime = 0)
  total_watched_runtime = current_user.total_watched_runtime - deleted_runtime
  @remaining_runtime = current_user.target_calorie / 113.0 * 90 / 60.0 - total_watched_runtime / 60.0
  current_user.update(remaining_runtime: @remaining_runtime)
  # 目標視聴時間に到達したかチェック
  return unless @remaining_runtime <= 0

  flash[:success] = t('.next_target_runtime')
end
