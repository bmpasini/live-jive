class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :bandname
      t.string :name
      t.text :bio
      t.string :website
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.string :activation_digest
      t.string :reset_digest
      t.boolean :identity_confirmed?, default: false
      t.datetime :activated_at
      t.datetime :reset_sent_at

      t.timestamps
    end
  end
end
