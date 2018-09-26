class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer :album_id
      t.integer :image_id

      t.string :password_digest
      t.string :name
      t.string :username
      t.string :email
      t.string :bio
      t.string :token
      t.string :admin

      t.timestamps
    end
  end
end
