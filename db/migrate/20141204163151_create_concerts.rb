class CreateConcerts < ActiveRecord::Migration
  def change
    create_table :concerts do |t|
      t.date :cdate
      t.time :ctime
      t.string :location_name
      t.string :ccity
      t.string :buy_tickets_website

      t.timestamps
    end
  end
end
