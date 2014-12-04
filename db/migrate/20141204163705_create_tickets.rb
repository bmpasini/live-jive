class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :tier
      t.integer :price
      t.integer :how_many_left
      t.references :concert

      t.timestamps
    end
  end
end
