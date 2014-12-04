class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :bandname
      t.string :name
      t.string :description
      t.string :website
      t.string :email
      t.boolean :identity_confirmed?

      t.timestamps
    end
  end
end
