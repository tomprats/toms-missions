class MissionariesController < ApplicationController
  before_filter :require_admin, only: :create

  def index
    @missionaries = Missionary.all
  end

  def show
    if params[:username]
      @missionary = Missionary.find_by(username: params[:username])
    else
      @missionary = current_user
    end
  end

  def edit
    if current_user.admin? && params[:username]
      @missionary = Missionary.find_by(username: params[:username])
    else
      @missionary = current_user
    end
  end

  def create
    @missionary = Missionary.create(missionary_params)
    redirect_to :back, notice: "#{@missionary.name} was created"
  end

  def update
    if current_user.admin? && params[:username]
      @missionary = Missionary.find_by(username: params[:username])
    else
      @missionary = current_user
    end
    @missionary.update_attributes(missionary_params)
    redirect_to root_path, notice: "#{@missionary.name} was updated"
  end

  def upload_profile
    image = Imgur.upload_profile(params[:image], current_user.name)
    current_user.delete_image if current_user.image
    current_user.update_attributes(image: image["link"])
    redirect_to :back, notice: "Profile picture was updated"
  end

  private
  def missionary_params
    params.require(:missionary).permit(
      :name,
      :username,
      :email,
      :bio,
      :password,
      :password_confirmation
    )
  end
end
