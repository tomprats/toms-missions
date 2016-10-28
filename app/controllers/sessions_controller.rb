class SessionsController < ApplicationController
  def new
    @user = User.new
    redirect_to root_path, warning: "You are already logged in" if current_user
  end

  def create
    @user = User.find_by(email: params[:session][:email].strip.downcase) || User.new
    if @user.try(:has_password?) && @user.authenticate(params[:session][:password])
      session[:current_user_id] = @user.id
      redirect_to root_path, success: "Logged in"
    else
      render :new, danger: "Incorrect credentials"
    end
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to root_path, success: "Logged out"
  end
end
