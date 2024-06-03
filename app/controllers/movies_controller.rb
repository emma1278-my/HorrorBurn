class MoviesController < ApplicationController
  require 'themoviedb-api'
  Tmdb::Api.key(ENV['TMDB_API'])
  Tmdb::Api.language('ja')
  HORROR_GENRE_ID = 27

  def search
    if params[:looking_for]
      movie_title = params[:looking_for]
      url = "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['TMDB_API']}&language=ja&query=" + URI.encode_www_form_component(movie_title)
    else
      url = "https://api.themoviedb.org/3/movie/popular?api_key=#{ENV['TMDB_API']}&language=ja"
      text = params[:looking_for]
      @movies = JSON.parse(Net::HTTP.get(URI.parse(url)))
    end
  end

  def show
    movie_id = params[:id]
    url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['TMDB_API']}&language=ja"
    response = Net::HTTP.get(URI.parse(url))
    @movie = JSON.parse(response)
    @movie_history = MovieHistory.new
  end
end

private

def movie_params
  params.require(:movie).permit(:title, :runtime)
end

def save_movie(movies)
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
