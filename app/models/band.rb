class Band < ActiveRecord::Base
	has_many :lineups
	has_many :concerts, through: :lineups

	has_many :band_plays_genres
	has_many :genres, through: :band_plays_genres
	
	has_many :fanships
	has_many :fans, through: :fanships 
end
