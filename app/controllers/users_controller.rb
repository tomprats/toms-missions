class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    if params[:username]
      @user = User.find_by(username: params[:username])
    else
      @user = current_user
    end
  end

  def edit
    if current_user.admin? && params[:username]
      @user = User.find_by(username: params[:username])
    else
      @user = current_user
    end
  end

  def create
    @user = User.create(user_params)
    redirect_to :back, notice: "#{@user.name} was created"
  end

  def update
    if current_user.admin? && params[:username]
      @user = User.find_by(username: params[:username])
    else
      @user = current_user
    end
    @user.update_attributes(user_params)
    redirect_to root_path, notice: "#{@user.name} was updated"
  end

  def upload_profile
    image = Image.with_imgur(
      title: current_user.name,
      image: params[:image],
      album_id: Album.profile["id"],
      user_id: current_user.id
    )
    current_user.image.destroy if current_user.image
    current_user.update_attributes(image_id: image.id)
    redirect_to :back, notice: "Profile picture was updated"
  end

  private
  def user_params
    params.require(:user).permit(
      :name,
      :username,
      :email,
      :bio,
      :password,
      :password_confirmation
    )
  end
end
