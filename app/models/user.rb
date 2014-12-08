class User < ActiveRecord::Base
  attr_accessor :remember_token, :reset_token, :genre_ids

  before_save :downcase_email

	has_many :fanships, foreign_key: :fan_id, dependent: :destroy
	has_many :favorite_bands, through: :fanships, source: :band

	has_many :concert_goings, foreign_key: :goer_id
	has_many :concerts, through: :concert_goings

	has_many :active_relationships, class_name:  "UserRelationship", foreign_key: :follower_id, dependent: :destroy
	has_many :passive_relationships, class_name:  "UserRelationship", foreign_key: :followed_id, dependent: :destroy

	has_many :following, through: :active_relationships, source: :followed
	has_many :followers, through: :passive_relationships

  has_many :user_likes_genres
  has_many :favorite_genres, through: :user_likes_genres, source: :genre

	has_many :concert_lists, foreign_key: :list_owner_id, dependent: :destroy

  has_secure_password

  before_save { self.email = email.downcase }

  validates :username,  presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 6 }, allow_blank: true

  validates :reputation_score, numericality: { only_integer: true, less_than_or_equal_to: 10 }

  # Retrieve all concerts that have bands who play genres that the user likes, which have been included in recommended lists of users he follows
  def concerts_from_followed_users_who_like_the_same_genres
    following_ids = "SELECT user_relationships.followed_id FROM user_relationships WHERE user_relationships.follower_id = :user_id"
    list_owner_ids = "SELECT users2.id FROM users users2 WHERE users2.id IN (#{following_ids})"
    concert_list_ids = "SELECT concert_lists.id FROM concert_lists WHERE concert_lists.list_owner_id IN (#{list_owner_ids})"
    recommended_concert_ids = "SELECT recommendations2.id FROM recommendations recommendations2 WHERE recommendations2.concert_list_id IN (#{concert_list_ids})"
    genre_ids = "SELECT genres2.genre FROM genres genres2 INNER JOIN user_likes_genres ON (user_likes_genres.genre_id = genres2.id) INNER JOIN users ON (users.id = user_likes_genres.user_id) WHERE users.id = :user_id"
    concert_ids = 
    "SELECT concerts2.id FROM concerts concerts2 INNER JOIN recommendations ON (recommendations.concert_id = concerts2.id) INNER JOIN lineups ON (lineups.concert_id = concerts2.id) INNER JOIN bands ON (bands.id = lineups.band_id) INNER JOIN band_plays_genres ON (band_plays_genres.band_id = bands.id) INNER JOIN genres ON (genres.id = band_plays_genres.genre_id) WHERE genres.genre IN (#{genre_ids}) AND concerts2.id IN (#{recommended_concert_ids})"
    Concert.where("id IN (#{concert_ids})", user_id: self.id)
  end

  # Retrieve all concerts that have bands who play genres that the user likes, which have been included in at least 5 recommended lists

  def popular_concerts_from_users_who_like_the_same_genres
    genre_ids = "SELECT genres2.genre FROM genres genres2 INNER JOIN user_likes_genres ON (user_likes_genres.genre_id = genres2.id) INNER JOIN users ON (users.id = user_likes_genres.user_id) WHERE users.id = :user_id"
    concert_ids = "SELECT concerts2.id FROM concerts concerts2 INNER JOIN recommendations ON (recommendations.concert_id = concerts2.id) INNER JOIN lineups ON (lineups.concert_id = concerts2.id) INNER JOIN bands ON (bands.id = lineups.band_id) INNER JOIN band_plays_genres ON (band_plays_genres.band_id = bands.id) INNER JOIN genres ON (genres.id = band_plays_genres.genre_id) WHERE genres.genre IN (#{genre_ids}) GROUP BY concerts2.id, recommendations.concert_list_id HAVING COUNT(*) >= 5"
    Concert.where("id IN (#{concert_ids})", user_id: self.id)
  end

  # Retrieve all bands who play genres that the user likes and that have at least 10 other fans
  def popular_bands_that_play_genres_the_user_like
    genre_ids = "SELECT genres2.genre FROM genres genres2 INNER JOIN user_likes_genres ON (user_likes_genres.genre_id = genres2.id) INNER JOIN users ON (users.id = user_likes_genres.user_id) WHERE users.id = :user_id"
    band_ids = "SELECT bands2.id FROM bands bands2 INNER JOIN fanships ON (fanships.band_id = bands2.id) INNER JOIN band_plays_genres ON (band_plays_genres.band_id = bands2.id) INNER JOIN genres ON (genres.id = band_plays_genres.genre_id) WHERE genres.genre IN (#{genre_ids}) GROUP BY fanships.band_id HAVING COUNT(*) >= 10"
    Band.where("id IN (#{band_ids})", user_id: User.first.id)
  end

  # Retrieve all bands who have had at least 1 concerts with average ratings greater or equal than 4
  def bands_with_good_concerts_that_play_genres_the_user_like
    genre_ids = "SELECT genres2.genre FROM genres genres2 INNER JOIN user_likes_genres ON (user_likes_genres.genre_id = genres2.id) INNER JOIN users ON (users.id = user_likes_genres.user_id) WHERE users.id = 1"
    band_ids = "SELECT DISTINCT bands2.id FROM bands bands2 INNER JOIN lineups ON (lineups.band_id = bands2.id) INNER JOIN concerts ON (concerts.id = lineups.concert_id) INNER JOIN concert_goings ON (concert_goings.concert_id = concerts.id) INNER JOIN band_plays_genres ON (band_plays_genres.band_id = bands2.id) INNER JOIN genres ON (genres.id = band_plays_genres.genre_id) WHERE genres.genre IN (#{genre_ids}) AND concert_goings.rating IS NOT NULL GROUP BY concert_goings.concert_id HAVING AVG(concert_goings.rating) >= 4"
    Band.where("id IN (#{band_ids})", user_id: User.first.id)
  end

  def set_genre(genre)
    user_likes_genres.create(genre_id: genre.id)
  end

  def likes_genre?(genre)
    self.genres.include?(genre)
  end

  # Genres that band plays.
  def likes_genres
    genres = Array.new
    self.favorite_genres.each do |genre|
      genres << genre.printable
    end
    genres.uniq
  end

  # Set reputation score.
  def set_reputation_score
    unless self.reputation_score == 10
      score = 0
      # If the user has created his account more than 1 week ago, then he will be awarded 1 point.
      score += 1 if self.created_at < Time.now.days_ago(7)
      # If the user has created his account more than 1 month ago, then he will be awarded 1 point.
      score += 1 if self.created_at < Time.now.days_ago(30)
      # For each concert review a user has made, he is awarded 1 point.
      number_of_reviews = 0
      self.concert_goings.each do |concert_going|
        number_of_reviews += 1 if concert_going.review 
      end
      score += number_of_reviews
      # For each concert recommendation a user has made, he is awarded 1 point.
      score += self.concert_lists.count

      self.reputation_score = (score > 10 ? 10 : score)
    end
  end

  # User can edit concerts.
  def can_edit_concerts?
    self.reputation_score >= 8 || self.is_admin?
  end

  # User can recommend concert lists.
  def can_recommend?
    self.reputation_score >= 1 || self.is_admin?
  end

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

	# Follows a user.
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  # Become fan of a band.
  def become_fan(band)
    fanships.create(band_id: band.id)
  end

  # Not a fan of the band anymore.
  def undo_become_fan(band)
    fanships.find_by(band_id: band.id).destroy
  end

  # Returns true if the current user is following the other user.
  def is_fan?(band)
    favorite_bands.include?(band)
  end

  # RSVP to concert.
  def rsvp(concert)
    concert_goings.create(concert_id: concert.id)
  end

  # Cancel RSVP.
  def cancel_rsvp(concert)
    concert_goings.find_by(concert_id: concert.id).destroy
  end

  # Returns true if the current user is going to concert.
  def is_going_to?(concert)
    concerts.include?(concert)
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver!
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private
    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end
end
