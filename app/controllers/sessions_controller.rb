class SessionsController < ApplicationController
  def new
    redirect_to root_path, notice: "You are already signed in" if current_user
  end

  def create
    missionary = Missionary.find_by(email: params[:session][:email])
    if missionary.try(:has_password?) && missionary.authenticate(params[:session][:password])
      session[:missionary_id] = missionary.id
      redirect_to root_path, notice: "Logged in"
    else
      redirect_to :back, notice: "Incorrect credentials"
    end
  end

  def destroy
    session[:missionary_id] = nil
    redirect_to root_path, notice: "Logged out"
  end
end
