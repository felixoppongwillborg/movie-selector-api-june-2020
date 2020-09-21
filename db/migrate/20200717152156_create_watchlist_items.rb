class CreateWatchlistItems < ActiveRecord::Migration[6.0]
  def change
    create_table :watchlist_items do |t| 
      t.references :watchlist, null: false, foreign_key: true
      t.string :title
      t.integer :movie_db_id, null: false 
      t.timestamps
    end
  end
end
