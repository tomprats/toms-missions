class UsersController < ApplicationController
  before_action :require_user, except: [:index, :show, :create]

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
    @user = User.new(user_params)
    if @user.save
      session[:current_user_id] = @user.id
      redirect_to root_path, success: "Signed Up!"
    else
      render "sessions/new", danger: "Profile could not be created (#{@user.errors.full_messages.join(", ")})"
    end
  end

  def update
    if current_user.admin? && params[:username]
      @user = User.find_by(username: params[:username])
    else
      @user = current_user
    end
    if @user.update(user_params)
      redirect_to user_path(username: @user.username), success: "Profile was updated"
    else
      redirect_back fallback_location: root_path, danger: "Profile could not be updated (#{@user.errors.full_messages.join(", ")})"
    end
  end

  def upload_image
    if current_user.admin? && params[:username]
      @user = User.find_by(username: params[:username])
    else
      @user = current_user
    end
    @user.update_profile_picture(params[:image])
    redirect_back fallback_location: root_path, success: "Profile picture was updated"
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
