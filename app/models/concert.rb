class Concert < ActiveRecord::Base
	has_many :lineups
	has_many :bands, through: :lineups

	has_many :concert_goings
	has_many :goers, through: :concert_goings

	has_many :recommendations
	has_many :concert_lists, through: :recommendations
	
	has_many :tickets

	validates :title, presence: true
	validates :description, presence: true
	validates :buy_tickets_website, presence: true

	def bands_playing
		bands = Array.new
		self.lineups.each do |lineup|
			bands << lineup.band
		end
		bands
	end

	def genres_played
		genres = Array.new
		self.bands_playing.each do |band|
			genres << band.plays_genres
		end
		genres.flatten.uniq
	end
end
