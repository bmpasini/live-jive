class CreateLineups < ActiveRecord::Migration
  def change
    create_table :lineups do |t|
      t.references :band
      t.references :concert

      t.timestamps
    end

    add_index :lineups, [:band_id, :concert_id], unique: true
  end
end
