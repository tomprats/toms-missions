class SessionsController < ApplicationController
  def new
    @user = User.new
    redirect_to root_path, notice: "You are already signed in" if current_user
  end

  def create
    @user = User.find_by(email: params[:session][:email]) || User.new
    if @user.try(:has_password?) && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Logged in"
    else
      flash[:error] = "Incorrect credentials"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out"
  end
end
