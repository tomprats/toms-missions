class MissionsController < ApplicationController
  before_action :verify_user!, only: [:images, :add_images, :delete_image]

  def index
    @user = User.find_by(username: params[:username])
    @missions = @user.missions
  end

  def show
    @user = User.find_by(username: params[:username])
    @trip = Trip.find_by(id: params[:trip_id])
    @mission = @user.missions.find_by(trip_id: params[:trip_id])
    unless @mission
      @user.missions.create(trip_id: params[:trip_id])
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
    @mission = current_user.missions.find_by(trip_id: params[:trip_id])
    unless @mission && params[:username] == current_user.username
      return redirect_to root_path, notice: "Unauthorized Access"
    end
  end
end
