class CreateConcertLists < ActiveRecord::Migration
  def change
    create_table :concert_lists do |t|
      t.string :title
      t.text :description
      t.references :list_owner

      t.timestamps
    end
    
    add_index :concert_lists, [:list_owner_id, :created_at]
  end
end
