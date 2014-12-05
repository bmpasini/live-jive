class CreateConcertLists < ActiveRecord::Migration
  def change
    create_table :concert_lists do |t|
      t.string :title
      t.text :description
      t.references :list_owner

      t.timestamps
    end
  end
end
