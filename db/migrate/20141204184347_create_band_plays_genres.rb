class CreateBandPlaysGenres < ActiveRecord::Migration
  def change
    create_table :band_plays_genres do |t|
      t.integer :band_id
      t.integer :genre_id

      t.timestamps
    end
  end
end
