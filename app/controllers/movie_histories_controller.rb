class MovieHistoriesController < ApplicationController
  def create
    @movie_history = current_user.movie_histories.build(movie_id: params[:movie_id])
    if @movie_history.save
      redirect_to dashboard_path, notice: '映画を記録しました。'
    else
      redirect_to movies_search_path, alert: '映画の記録に失敗しました。'
    end
  end
end
