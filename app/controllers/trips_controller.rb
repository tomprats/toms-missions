class TripsController < ApplicationController
  before_filter :require_admin, except: [:index, :show]

  def index
    @trips = Trip.all.includes(:images)
  end

  def new
    @trip = Trip.new
  end

  def show
    @trip = Trip.find_by(uid: params[:uid])
  end

  def create
    @trip = Trip.new(trip_params.merge(user_ids: [current_user.id]))

    if @trip.save
      redirect_to root_path, notice: "Trip album can be found at #{@trip.album.link}"
    else
      render :new, alert: "Trip is invalid"
    end
  end

  def edit
    @trip = Trip.find_by(uid: params[:uid])
  end

  def update
    @trip = Trip.find_by(uid: params[:uid])

    if @trip.update(trip_params)
      redirect_to root_path, notice: "Trip album updated"
    else
      render :new, alert: "Trip is invalid"
    end
  end

  def users
    @trip = Trip.find_by(uid: params[:uid])
    @users = User.all
  end

  def update_users
    @trip = Trip.find_by(uid: params[:uid])
    @trip.update(user_ids: params[:trip][:users].select { |id| !id.blank? })
    redirect_to trip_path(@trip), notice: "#{@trip.name}'s missionaries updated"
  end

  private
  def convert_to_date(date)
    Date.strptime(date, "%m/%d/%Y")
  end

  def trip_params
    params.require(:trip)
      .permit(:uid, :country, :description)
      .merge(
        start_date: convert_to_date(params[:trip][:start_date]),
        end_date: convert_to_date(params[:trip][:end_date])
      )
  end
end
