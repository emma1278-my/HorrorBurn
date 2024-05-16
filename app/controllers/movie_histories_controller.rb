class MovieHistoriesController < ApplicationController

  def create
    @movie_history = current_user.movie_histories.build(movie_history_params)
    if @movie_history.save
      redirect_to dashboards_url, notice: '映画視聴履歴に追加しました。'
    else
      redirect_to movies_search_path, alert: '映画視聴履歴の追加に失敗しました。'
    end
  end

  private

  def movie_history_params
    params.require(:movie_history).permit(:movie_id, :title, :runtime)
  end
end

