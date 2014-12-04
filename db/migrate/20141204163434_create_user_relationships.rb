class CreateUserRelationships < ActiveRecord::Migration
  def change
    create_table :user_relationships do |t|
      t.references :follower
      t.references :followed

      t.timestamps
    end
    
    add_index :user_relationships, :follower_id
    add_index :user_relationships, :followed_id
    add_index :user_relationships, [:follower_id, :followed_id], unique: true
  end
end
