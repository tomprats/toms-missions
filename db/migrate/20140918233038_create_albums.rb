class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :imgur_id
      t.string :link

      t.timestamps
    end
  end
end
