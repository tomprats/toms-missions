class AddImagesCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :images_count, :integer, default: 0, null: false

    User.find_each { |user| User.reset_counters(user.id, :images) }
  end
end
