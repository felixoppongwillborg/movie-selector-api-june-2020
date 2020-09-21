class User < ActiveRecord::Base
   after_create :create_watchlist
  
  extend Devise::Models
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_one :watchlist


private

  def create_watchlist
    Watchlist.create(user: self)
  end
end
