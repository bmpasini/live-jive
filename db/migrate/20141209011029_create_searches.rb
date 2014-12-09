class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :keywords
      t.string :city
      t.date :from_date
      t.date :to_date
      t.integer :genre_id

      t.timestamps
    end
  end
end
