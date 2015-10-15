class AddUidToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :uid, :string, index: true

    Trip.all.each do |trip|
      trip.send(:set_uid)
      trip.save
    end
  end
end
