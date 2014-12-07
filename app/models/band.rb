class Band < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save   :downcase_email
  before_create :create_activation_digest

	has_many :lineups
	has_many :concerts, through: :lineups

	has_many :band_plays_genres
	has_many :genres, through: :band_plays_genres
	
	has_many :fanships, dependent: :destroy
	has_many :fans, through: :fanships

	has_secure_password

  before_save { self.email = email.downcase }

  validates :bandname,  presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }

  validates :name,  presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 6 }, allow_blank: true

  validates :website,  presence: true, length: { maximum: 50 }

  validates :bio,  presence: true, length: { maximum: 1000 }

  scope :desc, order("bands.created_at DESC")

  def plays_genre?(genre)
    self.genres.include?(genre)
  end

  # Genres that band plays.
  def plays_genres
    genres = Array.new
    self.genres.each do |genre|
      genres << genre.printable
    end
    genres.uniq
  end

  # Bands plays in concert?
  def plays_in_concert?(concert)
    concert.lineups.each do |lineup|
      return true if self.lineups.include? (lineup)
    end
    false
  end

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def Band.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = Band.new_token
    update_attribute(:remember_digest, Band.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a band.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Activates an account.
  def activate
    update_attribute(:identity_confirmed?, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    BandMailer.account_activation(self).deliver!
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = Band.new_token
    update_attribute(:reset_digest,  Band.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    BandMailer.password_reset(self).deliver!
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

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = Band.new_token
      self.activation_digest = Band.digest(activation_token)
    end
end
