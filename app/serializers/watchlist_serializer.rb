class WatchlistSerializer < ActiveModel::Serializer
  attributes :id
  has_many :watchlist_items
end
