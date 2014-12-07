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
end
