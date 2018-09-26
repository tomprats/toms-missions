class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :imgur_id
      t.string :link

      t.integer :user_id
      t.integer :trip_id

      t.timestamps
    end
  end
end
