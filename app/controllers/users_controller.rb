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
    @user.update(user_params)
    redirect_to :back, notice: "Profile was updated"
  end

  def upload_profile_picture
    current_user.create_profile_picture(params[:image])
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
