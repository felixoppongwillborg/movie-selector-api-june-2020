FactoryBot.define do
  factory :watchlist_item do
    movie_db_id { 699 }
    title { 'For Your Eyes Only' }
    watchlist
  end
end
