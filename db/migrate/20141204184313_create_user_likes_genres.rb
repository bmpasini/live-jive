class CreateUserLikesGenres < ActiveRecord::Migration
  def change
    create_table :user_likes_genres do |t|
      t.integer :user_id
      t.integer :genre_id

      t.timestamps
    end
  end
end
