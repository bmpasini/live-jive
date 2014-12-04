class CreateBandPlaysGenres < ActiveRecord::Migration
  def change
    create_table :band_plays_genres do |t|
      t.references :band
      t.references :genre

      t.timestamps
    end
  end
end
