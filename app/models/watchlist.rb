class Watchlist < ApplicationRecord
    has_many :watchlist_items
    belongs_to :user
end
