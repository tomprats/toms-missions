class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :imgur_id
      t.string :link

      t.integer :user_id
      t.integer :trip_id

      t.timestamps
    end
  end
end
