class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    User.find(session[:user_id]) rescue nil
  end
  helper_method :current_user

  def require_user
    redirect_to root_path, notice: "You are not allowed there" unless current_user
  end
  helper_method :require_user

  def require_admin
    redirect_to root_path, notice: "You are not allowed there" unless current_user && current_user.admin?
  end
  helper_method :require_admin
end
