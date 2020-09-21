class Api::V1::MoviesController < ApplicationController
  def show 
    random_page = rand(1..500)
    api_endpoint = "https://api.themoviedb.org/3/discover/movie?api_key=80089a9e6edb5f524156c569cd8a9a69&page=#{random_page}"
    results = RestClient.get(api_endpoint)
    movies = JSON.parse(results.body)["results"]
    random_movie = movies[rand(0..((movies.count)-1))]
    render json: {movie: random_movie}
  end
end
