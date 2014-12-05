class Band < ActiveRecord::Base
	has_many :lineups
	has_many :concerts, through: :lineups

	has_many :band_plays_genres
	has_many :genres, through: :band_plays_genres
	
	has_many :fanships
	has_many :fans, through: :fanships 

	has_secure_password

  before_save { self.email = email.downcase }

  validates :bandname,  presence: true, length: { maximum: 10 }

  validates :name,  presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 6 }

  validates :website,  presence: true, length: { maximum: 50 }

  validates :bio,  presence: true, length: { maximum: 1000 }

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
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
