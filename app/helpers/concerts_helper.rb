module ConcertsHelper
	def pre_band_ids
		band_ids = Array.new
		@concert.lineups.each do |lineup|
			band_ids << lineup.band_id.to_s
		end
		band_ids
	end

	def url_with_protocol(url)
    /^http/i.match(url) ? url : "http://#{url}"
  end

  def any_reviews?
  	@concert.concert_goings.each do |rsvp|
  		return true if rsvp.review
  	end
  	false
  end

  def average_rating
  	ratings = Array.new
  	@concert.concert_goings.each do |rsvp|
  		ratings << rsvp.rating if rsvp.rating
  	end
  	ratings.inject{ |sum, el| sum + el }.to_f / ratings.size
  end

  def range_arr(max)
  	range = Array.new
  	max.times { |n| range << n + 1 }
  	range
  end
end
