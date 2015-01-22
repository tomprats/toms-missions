class TripsController < ApplicationController
  def create
    country = params[:trip][:country]
    start_date = params[:trip][:start_date]
    end_date = params[:trip][:end_date]
    trip = Trip.new(
      country: country,
      start_date: start_date,
      end_date: end_date
    )

    if trip.save
      album = Album.with_imgur(title: "#{country} #{start_data.month} #{start_date.year}")
      trip = Trip.update(album_id: album.id)
      album.update(trip_id: trip.id)
      redirect_to :back, notice: "Trip album can be found at #{album.link}"
    else
      redirect_to :back, notice: "Trip is invalid"
    end
  end
end
