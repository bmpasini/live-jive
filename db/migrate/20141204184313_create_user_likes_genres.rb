class CreateUserLikesGenres < ActiveRecord::Migration
  def change
    create_table :user_likes_genres do |t|
      t.references :user
      t.references :genre

      t.timestamps
    end
  end
end
