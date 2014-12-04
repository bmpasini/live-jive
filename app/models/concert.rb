class Concert < ActiveRecord::Base
	has_many :lineups
	has_many :bands, through: :lineups

	has_many :concert_goings
	has_many :goers, through: :concert_goings

	has_many :recommendations
	has_many :concert_lists, through: :recommendations
	
	has_many :tickets
end
