class CreateMissionaries < ActiveRecord::Migration
  def change
    create_table :missionaries do |t|
      t.string :password_digest
      t.string :name
      t.string :username
      t.string :email
      t.string :image
      t.string :bio
      t.string :token
      t.string :admin

      t.timestamps
    end
  end
end
