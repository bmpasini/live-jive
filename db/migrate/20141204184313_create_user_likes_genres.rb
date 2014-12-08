class CreateUserLikesGenres < ActiveRecord::Migration
  def change
    create_table :user_likes_genres do |t|
      t.references :user
      t.references :genre

      t.timestamps
    end

    add_index :user_likes_genres, [:user_id, :genre_id], unique: true
  end
end
