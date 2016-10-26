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
      redirect_to root_path, notice: "Signed Up!"
    else
      render "sessions/new", error: "Profile could not be created (#{@user.errors.full_messages.join(", ")})"
    end
  end

  def update
    if current_user.admin? && params[:username]
      @user = User.find_by(username: params[:username])
    else
      @user = current_user
    end
    @user.update(user_params)
    if @user.errors.empty?
      redirect_to user_path(username: @user.username), notice: "Profile was updated"
    else
      redirect_to :back, error: "Profile could not be updated (#{@user.errors.full_messages.join(", ")})"
    end
  end

  def upload_image
    if current_user.admin? && params[:username]
      @user = User.find_by(username: params[:username])
    else
      @user = current_user
    end
    @user.update_profile_picture(params[:image])
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
