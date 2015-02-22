class TripsController < ApplicationController
  before_filter :require_admin, except: [:index, :show]

  def index
    @trips = Trip.all
  end

  def new
    @trip = Trip.new
  end

  def show
    @trip = Trip.find(params[:id])
  end

  def create
    country = params[:trip][:country]
    start_date = convert_to_date(params[:trip][:start_date])
    end_date = convert_to_date(params[:trip][:end_date])
    @trip = Trip.new(
      country: country,
      start_date: start_date,
      end_date: end_date,
      user_ids: [current_user.id]
    )

    if @trip.save
      redirect_to root_path, notice: "Trip album can be found at #{@trip.album.link}"
    else
      render :new, alert: "Trip is invalid"
    end
  end

  def users
    @trip = Trip.find(params[:id])
    @users = User.all
  end

  def update_users
    @trip = Trip.find(params[:id])
    @trip.update(user_ids: params[:trip][:users].select { |id| !id.blank? })
    redirect_to trip_path(@trip.id), notice: "#{@trip.name}'s missionaries updated"
  end

  private
  def convert_to_date(date)
    Date.strptime(date, "%m/%d/%Y")
  end
end
