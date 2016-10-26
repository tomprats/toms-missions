class FavoritesController < ApplicationController
  before_action :require_user, except: :index

  def toggle
    if @fav = current_user.favorites.find_by(image_id: params[:image_id])
      @fav.destroy
    else
      current_user.favorites.create(image_id: params[:image_id])
    end
    render json: { favorite: !@fav }
  end

  def index
    @user = User.find_by(username: params[:username])
    @images = @user.favorite_images.page(params[:page]).per(24)
  end
end
