class MoviesController < ApplicationController
  #require 'themoviedb-api'
  #Tmdb::Api.key("ご自身のAPI Key")
  #Tmdb::Api.language("ja") # こちらで映画情報の表示の際の言語設定を日本語にできます

  def search
    # クエリパラメータから検索キーワードを取得
    #query = params[:query]

    # TMDb APIを検索するためのロジックをここに書く
    # (例) response = MovieSearchService.new.search(query)

    # 検索結果をビューに渡す
    # (例) @movies = response["results"]
  end


  
end
