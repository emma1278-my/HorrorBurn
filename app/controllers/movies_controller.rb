class MoviesController < ApplicationController
  require 'themoviedb-api'
  Tmdb::Api.key(ENV['TMDB_API'])
  Tmdb::Api.language("ja")


  def search
    if params[:looking_for]
      movie_title = params[:looking_for]
      movies = []
      (1..5).each do |page|
        url = "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['TMDB_API']}&language=ja&query=" + URI.encode_www_form_component(movie_title) + "&page=#{page}"
        response = Net::HTTP.get_response(URI.parse(url))
        if response.code == "200"
          result = JSON.parse(response.body)
          movies.concat(result["results"])
        end
      end
    else
      movies = []
      (1..5).each do |page|
        url = "https://api.themoviedb.org/3/movie/popular?api_key=#{ENV['TMDB_API']}&language=ja&page=#{page}"
        response = Net::HTTP.get_response(URI.parse(url))
        if response.code == "200"
          result = JSON.parse(response.body)
          movies.concat(result["results"])
        end
      end
    end
    @movies = Kaminari.paginate_array(movies).page(params[:page]).per(20)
  end



  def show
    movie_id = params[:id]
    url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['TMDB_API']}&language=ja"
    response = Net::HTTP.get(URI.parse(url))
    @movie = JSON.parse(response)
  end
end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: '映画が正常に作成されました。'
    else
      render :new
    end
  end

private 

  def movie_params
    params.require(:movie).permit(:title, :runtime)
  end

def save_movies(movies)
  current_user = User.find(session[:user_id])
  movies.each do |movie_data|
    movie = Movie.find_or_initialize_by(tmdb_id: movie_data['id'])
    unless movie.persisted?
      movie.title = movie_data['title']
      movie.runtime = movie_data['runtime']
      movie.save!
    end
    MovieHistory.create!(user_id: current_user.id, movie_id: movie.id)
  end
end