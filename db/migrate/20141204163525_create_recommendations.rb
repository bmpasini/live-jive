class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.references :concert
      t.references :concert_list

      t.timestamps
    end

    add_index :recommendations, [:concert_list_id, :concert_id], unique: true
    end
  end
