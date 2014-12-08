class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :name
      t.integer :year_of_birth
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.string :reset_digest
      t.string :city_of_birth
      t.integer :reputation_score, default: 0
      t.boolean :is_admin?, default: false
      t.datetime :reset_sent_at
      t.datetime :penultimate_login_at, default: Time.now
      t.datetime :last_login_at, default: Time.now

      t.timestamps
    end
  end
end
