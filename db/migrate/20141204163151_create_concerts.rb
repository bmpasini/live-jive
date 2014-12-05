class CreateConcerts < ActiveRecord::Migration
  def change
    create_table :concerts do |t|
      t.string :title
      t.text :description
      t.string :buy_tickets_website
      t.datetime :cdatetime
      t.string :location_name
      t.string :ccity

      t.timestamps
    end
  end
end