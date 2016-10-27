class TokensController < ApplicationController
  def create
    if user = User.find_by(email: params[:email])
      UserMailer.token(user).deliver_now
      redirect_back fallback_location: login_path, success: "Email Sent!"
    else
      redirect_back fallback_location: login_path, danger: "Unknown Email"
    end
  end

  def show
    if user = User.joins(:tokens).find_by(tokens: { uid: params[:uid] })
      session[:current_user_id] = user.id
      redirect_to me_path, success: "Logged in"
    else
      redirect_to login_path, danger: "Invalid Token"
    end
  end
end
