class CreateFanships < ActiveRecord::Migration
  def change
    create_table :fanships do |t|
      t.references :band
      t.references :fan

      t.timestamps
    end

    add_index :fanships, [:band_id, :fan_id], unique: true
  end
end
