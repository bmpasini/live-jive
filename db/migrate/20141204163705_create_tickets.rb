class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :concert_id
      t.string :type
      t.integer :price
      t.integer :how_many_left

      t.timestamps
    end
  end
end
