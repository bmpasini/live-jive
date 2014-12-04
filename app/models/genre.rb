class Genre < ActiveRecord::Base
	belongs_to :band_plays_genre
	belongs_to :user_likes_genre
end
