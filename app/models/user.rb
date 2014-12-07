class User < ActiveRecord::Base
  attr_accessor :remember_token, :reset_token
  before_save   :downcase_email

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
    self.reputation_score >= 8
  end

  # User can recommend concert lists.
  def can_recommend?
    self.reputation_score >= 1
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
