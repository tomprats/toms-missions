class MissionsController < ApplicationController
  before_action :verify_user!, only: [:images, :add_images, :delete_image]

  def index
    @user = User.find_by(username: params[:username])
    @missions = @user.missions
  end

  def show
    @user = User.find_by(username: params[:username])
    @trip = Trip.find_by(uid: params[:trip_uid])
    unless @mission = @user.missions.find_by(trip_id: @trip.id)
      @user.missions.create(trip_id: @trip.id)
    end
  end

  def images
    @trip = @mission.trip
  end

  def add_images
    image_id = Image.with_imgur(
      title: "#{@mission.trip.name} - #{current_user.username}",
      image: params[:image],
      album_id: @mission.album.imgur_id,
      user_id: current_user.id,
      trip_id: @mission.trip_id
    ).imgur_id

    @mission.trip.album.add_images([image_id])

    render json: { success: true }
  rescue Imgur::ImgurError => e
    logger.debug "Imgur Error #{e.message}"

    render json: { error: e.message }
  end

  def delete_image
    @image = @mission.images.find_by(id: params[:id])
    @image.destroy
    redirect_to :back
  end

  private
  def verify_user!
    @trip = Trip.find_by(uid: params[:trip_uid])
    @mission = current_user.missions.find_by(trip_id: @trip.id)
    unless @mission && params[:username] == current_user.username
      return redirect_to root_path, danger: "Unauthorized Access"
    end
  end
end
