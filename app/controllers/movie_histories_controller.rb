class MovieHistoriesController < ApplicationController

  def create
    @movie = Movie.new(title: params[:title], runtime: params[:runtime])
    
    if @movie_history.save
      @movie_history = current_user.movie_histories.build(movie: @movie)
      redirect_to dashboard_path, success: t('.success')
    else
      redirect_to movies_search_path(movie_id: params[:movie_id]), alert: '視聴履歴の追加に失敗しました。'
    end
  end
end
