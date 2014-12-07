class Concert < ActiveRecord::Base
	attr_accessor :band_tokens, :band_ids
	attr_reader :band_tokens

	has_many :lineups, dependent: :destroy
	has_many :bands, through: :lineups

	has_many :concert_goings, dependent: :destroy
	has_many :goers, through: :concert_goings

	has_many :recommendations, dependent: :destroy
	has_many :concert_lists, through: :recommendations
	
	has_many :tickets, dependent: :destroy

	validates :title, presence: true
	validates :description, presence: true
	validates :buy_tickets_website, presence: true

	def set_lineup(band)
		lineups.create(band_id: band.id)
	end

	def band_tokens=(ids)
		self.band_ids = ids.split(",")
	end

	def bands_playing
		bands = Array.new
		self.lineups.each do |lineup|
			bands << lineup.band
		end
		bands
	end

	def band_in_concert?(band)
		bands_playing.include?(band)
	end

	def genres_played
		genres = Array.new
		self.bands_playing.each do |band|
			genres << band.plays_genres
		end
		genres.flatten.uniq
	end
end
