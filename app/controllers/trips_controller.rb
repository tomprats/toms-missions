class TripsController < ApplicationController
  before_filter :require_admin, except: [:index, :show]

  def index
    @trips = Trip.all
  end

  def new
    @trip = Trip.new
  end

  def show
    @trip = Trip.find_by(uid: params[:uid])
  end

  def create
    start_date = convert_to_date(params[:trip][:start_date])
    end_date = convert_to_date(params[:trip][:end_date])
    @trip = Trip.new(
      uid: params[:trip][:uid],
      country: params[:trip][:country],
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
end
