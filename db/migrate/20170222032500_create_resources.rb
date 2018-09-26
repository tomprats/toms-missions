class CreateResources < ActiveRecord::Migration[5.2]
  def change
    create_table :resources do |t|
      t.integer :trip_id

      t.string :text
      t.string :url

      t.timestamps
    end
  end
end
