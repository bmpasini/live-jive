class CreateConcertGoings < ActiveRecord::Migration
  def change
    create_table :concert_goings do |t|
      t.string :review
      t.integer :rating
      t.references :goer
      t.references :concert

      t.timestamps
    end
  end
end
