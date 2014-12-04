class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.integer :concert_id
      t.integer :concert_list_id

      t.timestamps
    end
  end
end
