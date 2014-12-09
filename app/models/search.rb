class Search < ActiveRecord::Base

  def concerts
	  @concerts ||= find_concerts
	end

	private

		def find_concerts
      if genre_id.present?
      	genre = Genre.find(genre_id)
      	concerts = Concert.find_by_sql("SELECT * FROM concerts INNER JOIN lineups ON (concerts.id = lineups.concert_id) INNER JOIN bands ON (bands.id = lineups.band_id) INNER JOIN band_plays_genres ON (bands.id = band_plays_genres.band_id) INNER JOIN genres ON (genres.id = band_plays_genres.genre_id) WHERE genre = ? AND subgenre = ? ORDER BY concerts.title", genre.genre, genre.subgenre)
      else
      	concerts = Concert.order(:title)
      end
		  concerts = concerts.where("title LIKE ? OR description LIKE ?", "%#{keywords}%", "%#{keywords}%") if keywords.present?
		  concerts = concerts.where("DATE(cdatetime) >= ?", from_date) if from_date.present?
		  concerts = concerts.where("DATE(cdatetime) <= ?", to_date) if to_date.present?
		  concerts
		end
end
