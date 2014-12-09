class Concert < ActiveRecord::Base
	attr_accessor :band_tokens, :band_ids, :vip_tickets_how_many_left, :vip_tickets_price, :confort_how_many_left, :confort_price, :pavillion_tickets_how_many_left, :pavillion_tickets_price, :front_row_tickets_how_many_left, :front_row_tickets_price, :lounge_tickets_how_many_left, :lounge_tickets_price
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

	def self.search(search)
	  if search
	    where("title LIKE ? OR description LIKE ?", "%#{search}%", "%#{search}%")
	  else
	    all
	  end
	end

	def average_rating
  	ratings = Array.new
  	if concert_goings.any?
	  	concert_goings.each do |rsvp|
	  		ratings << rsvp.rating if rsvp.rating
	  	end
  	end
  	ratings.inject{ |sum, el| sum + el }.to_f / ratings.size
  end

	def set_ticket(ticket)
		tickets.create(ticket)
	end

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
