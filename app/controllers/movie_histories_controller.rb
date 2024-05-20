class MovieHistoriesController < ApplicationController

  def create
    @movie_history = current_user.movie_histories.build(movie_history_params)
    if @movie_history.save
      update_remaining_runtime
      redirect_to dashboards_url, notice: '映画視聴履歴に追加しました。'
    else
      redirect_to movies_search_path, alert: '映画視聴履歴の追加に失敗しました。'
    end
  end

  private

  def movie_history_params
    params.require(:movie_history).permit(:movie_id, :title, :runtime)
  end

  def update_remaining_runtime
    total_watched_runtime = current_user.total_watched_runtime
    @remaining_runtime = current_user.target_calorie  / 113.0 * 90 / 60.0 - total_watched_runtime / 60.0
    current_user.update(remaining_runtime: @remaining_runtime)
    # 目標視聴時間に到達したかチェック
    if @remaining_runtime <= 0
      flash[:success] = t(".next_target_runtime")
    end
  end
end

