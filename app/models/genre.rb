class Genre < ActiveRecord::Base
	has_many :band_plays_genres
	has_many :bands, through: :band_plays_genres

	has_many :user_likes_genres
	has_many :users, through: :user_likes_genres

	def printable
		if self.genre == self.subgenre
        return self.genre
    else
      return [self.genre, self.subgenre].join(" (").concat(")")
    end
	end
end
