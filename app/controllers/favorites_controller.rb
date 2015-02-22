class FavoritesController < ApplicationController
  before_action :require_user, except: :index

  def toggle
    @fav = current_user.favorites.find_by(image_id: params[:image_id])
    if @fav
      @fav.destroy
    else
      current_user.favorites.create(image_id: params[:image_id])
    end
    render json: { favorite: !@fav }
  end

  def index
    @user = User.find(params[:user_id])
    @images = @user.favorite_images.page(params[:page]).per(24)
  end
end
