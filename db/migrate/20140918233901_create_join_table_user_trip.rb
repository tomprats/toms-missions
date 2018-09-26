class CreateJoinTableUserTrip < ActiveRecord::Migration[5.2]
  def change
    create_table :missions do |t|
      t.integer :user_id
      t.integer :trip_id
      t.integer :album_id

      t.index [:user_id, :trip_id]
      t.index [:trip_id, :user_id]
    end
  end
end
