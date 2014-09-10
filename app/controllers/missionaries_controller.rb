class MissionariesController < ApplicationController
  def index
    @missionaries = Missionary.all
  end

  def show
    @missionary = Missionary.find_by(username: params[:username])
  end

  def edit
    if current_user.admin? && params[:username]
      @missionary = Missionary.find_by(username: params[:username])
    else
      @missionary = current_user
    end
  end

  def create
    @missionary = Missionary.create(missionary_params)
    redirect_to :back, notice: "#{@missionary.name} was created"
  end

  def edit
  end

  def update
    if current_user.admin? && params[:username]
      @missionary = Missionary.find_by(username: params[:username])
    else
      @missionary = current_user
    end
  end

  def destroy
  end

  private
  def missionary_params
    params.require(:missionary).permit(
      :name,
      :username,
      :email,
      :bio,
      :password,
      :password_confirmation
    )
  end
end
