class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.references :concert
      t.references :concert_list

      t.timestamps
    end
  end
end
