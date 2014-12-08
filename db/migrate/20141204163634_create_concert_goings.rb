class CreateConcertGoings < ActiveRecord::Migration
  def change
    create_table :concert_goings do |t|
      t.text :review
      t.integer :rating
      t.references :goer
      t.references :concert

      t.timestamps
    end

    add_index :concert_goings, [:goer_id, :concert_id], unique: true
  end
end
