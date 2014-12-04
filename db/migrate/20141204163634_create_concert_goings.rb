class CreateConcertGoings < ActiveRecord::Migration
  def change
    create_table :concert_goings do |t|
      t.string :review
      t.integer :rating
      t.integer :goer_id
      t.integer :concert_id

      t.timestamps
    end
  end
end
