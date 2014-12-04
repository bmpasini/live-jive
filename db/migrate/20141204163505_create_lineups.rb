class CreateLineups < ActiveRecord::Migration
  def change
    create_table :lineups do |t|
      t.integer :band_id
      t.integer :concert_id

      t.timestamps
    end
  end
end
