# frozen_string_literal: true

class MoviesController < ApplicationController
  require 'themoviedb-api'
  Tmdb::Api.key(ENV['TMDB_API'])
  Tmdb::Api.language('ja')
  HORROR_GENRE_ID = 27

  def search
    if params[:looking_for]
      movie_title = params[:looking_for].strip
      if movie_title.empty?
        flash[:error] = '映画のタイトルを入力してください。'
        redirect_to root_path and return
      end

      url = "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['TMDB_API']}&language=ja&query=" + URI.encode_www_form_component(movie_title)
    else
      url = "https://api.themoviedb.org/3/movie/popular?api_key=#{ENV['TMDB_API']}&language=ja"
    end
    @movies = JSON.parse(Net::HTTP.get(URI.parse(url)))
  rescue JSON::ParserError
    flash[:error] = '映画情報の取得に失敗しました。'
    redirect_to root_path
  end

  def show
    movie_id = params[:id]
    url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['TMDB_API']}&language=ja"
    response = Net::HTTP.get(URI.parse(url))
    @movie = JSON.parse(response)
    @movie_history = MovieHistory.new
  end


  def autocomplete
    query = params[:looking_for]
    url = "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['TMDB_API']}&language=ja&query=#{URI.encode(query)}"
    @movies = JSON.parse(Net::HTTP.get(URI.parse(url)))
    render json: @movies['results'].map { |movie| { title: movie['title'] } }
  end
end

private

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
