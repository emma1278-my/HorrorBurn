class MovieHistoriesController < ApplicationController
  
  def create
    @movie_history = MovieHistory.new(movie_history_params)
    @movie_history.user_id = current_user.id
    @movie_history.movie_id = params[:movie_id] 

    if @movie_history.save
      redirect_to dashboard_path, notice: '映画視聴履歴に追加しました。'
    else
      redirect_to movies_search_path, alert: '映画視聴履歴の追加に失敗しました。'
    end
  end

  def like(params = {})
  user_id = params[:user_id]
  likes = Like.where(user_id: user_id).order(created_at: :desc).pluck(:movie_id)
  @likeslist = []
  likes.map do |id|
  uri = URI.parse("https://api.themoviedb.org/3/tv/#{id}?api_key=#{ENV['API_KEY']}&language=ja-JP")
  json = Net::HTTP.get(uri)
  result = JSON.parse(json)
  likeslist = result
  @likeslist += [likeslist]
  end
  list = @likeslist
  list.map do |list|
    Movie.new(list)
  end
end

  private

  def movie_history_params
    params.require(:movie_history).permit(:movie_id, :title, :runtime)
  end
end