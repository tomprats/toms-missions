class SessionsController < ApplicationController
  def new
    redirect_to root_path, notice: "You are already signed in" if current_user
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user.try(:has_password?) && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged in"
    else
      redirect_to :back, notice: "Incorrect credentials"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out"
  end
end
