class CreateConcertLists < ActiveRecord::Migration
  def change
    create_table :concert_lists do |t|
      t.integer :list_owner_id
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
