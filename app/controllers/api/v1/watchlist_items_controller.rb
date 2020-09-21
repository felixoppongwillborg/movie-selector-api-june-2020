class Api::V1::WatchlistItemsController < ApplicationController
  before_action :authenticate_user!
 
  def create
    if current_user.subscriber
      watchlist = current_user.watchlist
      watchlist.watchlist_items.create(title: params["title"], movie_db_id: params["movie_db_id"])
      json = { watchlist: WatchlistSerializer.new(watchlist) }
      json.merge!(message: 'The movie has been added to your watchlist')
      render json: json
      else
      render json: { message: "You need to become a subscriber before you can add anything to your watchlist" }, status: 401
    end
  end
end