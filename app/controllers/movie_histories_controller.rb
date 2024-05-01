class MovieHistoriesController < ApplicationController

  def create
    @movie = Movie.find(params[:movie_id])
    @movie_history = current_user.movie_histories.build(movie: @movie)
    if @movie_history.save
      redirect_to dashboard_path, notice: '視聴履歴に追加しました。'
    else
      redirect_to movies_search_path(movie_id: params[:movie_id]), alert: '視聴履歴の追加に失敗しました。'
    end
  end
end
