class Search < ActiveRecord::Base

  def concerts
	  @concerts ||= find_concerts
	end

	private

		def find_concerts
			concerts = Concert.order(:title)
      if genre_id.present?
      	genre = Genre.find(genre_id)
      	concert_ids = "SELECT concerts.id FROM concerts INNER JOIN lineups ON (concerts.id = lineups.concert_id) INNER JOIN bands ON (bands.id = lineups.band_id) INNER JOIN band_plays_genres ON (bands.id = band_plays_genres.band_id) INNER JOIN genres ON (genres.id = band_plays_genres.genre_id) WHERE genre = ? AND subgenre = ? ORDER BY concerts.title"
	      concerts = concerts.where("id IN (#{concert_ids})", genre.genre, genre.subgenre)
	    end
		  concerts = concerts.where("title LIKE ? OR description LIKE ?", "%#{keywords}%", "%#{keywords}%") if keywords.present?
		  concerts = concerts.where("DATE(cdatetime) >= ?", from_date) if from_date.present?
		  concerts = concerts.where("DATE(cdatetime) <= ?", to_date) if to_date.present?
		  concerts
		end
end
