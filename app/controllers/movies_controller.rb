class MoviesController < ApplicationController
  Tmdb::Api.language("ja")


  def search
    page_number = params[:page] || 1
    if params[:looking_for]
      movie_title = params[:looking_for]
      url = "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['TMDB_API']}&language=ja&query=" + URI.encode_www_form_component(movie_title)
    else
      url = "https://api.themoviedb.org/3/movie/popular?api_key=#{ENV['TMDB_API']}&language=ja"
    end
    response = Net::HTTP.get(URI.parse(url))
    @movies = Kaminari.paginate_array(JSON.parse(response)['results']).page(page_number).per(10)
  end
  
  def show
    movie_id = params[:id]
    url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['TMDB_API']}&language=ja"
    response = Net::HTTP.get(URI.parse(url))
    @movie = JSON.parse(response)
  end
end
