class User < ActiveRecord::Base
	has_many :fanships, foreign_key: :fan_id
	has_many :favorite_bands, through: :fanships, source: :band

	has_many :concert_goings, foreign_key: :goer_id
	has_many :concerts, through: :concert_goings

	has_many :active_relationships, class_name:  "UserRelationship", foreign_key: :follower_id
	has_many :passive_relationships, class_name:  "UserRelationship", foreign_key: :followed_id, dependent: :destroy
	has_many :following, through: :active_relationships, source: :followed
	has_many :followers, through: :passive_relationships

  has_many :user_likes_genres
  has_many :favorite_genres, through: :user_likes_genres, source: :genre

	has_many :concert_lists, foreign_key: :list_owner_id

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
end
