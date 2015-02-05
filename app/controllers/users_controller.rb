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
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Logged in"
    else
      flash[:error] = "Profile could not be created (#{@user.errors.full_messages.join(", ")})"
      render "sessions/new"
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
      redirect_to :back, notice: "Profile was updated"
    else
      redirect_to :back, alert: "Profile could not be updated (#{@user.errors.full_messages.join(", ")})"
    end
  end

  def upload_profile_picture
    current_user.update_profile_picture(params[:image])
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
