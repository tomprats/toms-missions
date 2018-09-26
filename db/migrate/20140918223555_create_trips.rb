class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.integer :album_id

      t.string :country
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
