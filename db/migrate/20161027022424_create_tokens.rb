class CreateTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :tokens do |t|
      t.integer :user_id, index: true
      t.string :uid, index: true

      t.timestamps
    end
  end
end
