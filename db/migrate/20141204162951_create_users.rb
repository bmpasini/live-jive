class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :name
      t.integer :year_of_birth
      t.string :email
      t.string :password
      t.string :city_of_birth
      t.integer :reputation_score
      t.boolean :is_admin?
      t.datetime :last_login_at
      t.datetime :current_login_at

      t.timestamps
    end
  end
end
