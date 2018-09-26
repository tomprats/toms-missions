class ResourcesController < ApplicationController
  before_action :require_admin

  def index
    @resources = Resource.all
  end

  def new
    @resource = Resource.new
  end

  def create
    @resource = Resource.new(resource_params)

    if @resource.save
      redirect_to resources_path, success: "Resource created"
    else
      render :new, danger: "Resource is invalid"
    end
  end

  def edit
    @resource = Resource.find(params[:id])
  end

  def update
    @resource = Resource.find(params[:id])

    if @resource.update(resource_params)
      redirect_to resources_path, success: "Resource updated"
    else
      render :new, danger: "Resource is invalid"
    end
  end

  private
  def resource_params
    params.require(:resource).permit(:trip_id, :text, :url)
  end
end
