class LocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_location, only: [:client_list, :show, :edit, :update, :destroy]
  
  def index 
    @locations = current_user.locations
  end
  
  def client_list 
    @clients = @location.clients
  end
  
  def show 
    @appointments = @location.appointments
  end
  
  def new 
    @location = Location.new
  end
  
  def create 
    @location = Location.new(location_params)
    if @location.valid?
      @location.user = current_user
      @location.save 
      redirect_to locations_path
    else 
      render :new
    end
  end
  
  def edit 
  end 
  
  def update 
    if @location.update(location_params)
      redirect_to location_path(@location)
    else 
      render :edit
    end
  end
  
  def destroy 
    @location.destroy 
    redirect_to locations_path
  end
  
  private 
  
  def set_location 
    @location = current_user.locations.find_by(id: params[:id])
    if @location.nil?
      flash[:error] = "Location not found."
      redirect_to locations_path
    end
  end
  
  def location_params
    params.require(:location).permit(:nickname, :street_address, :city, :state, :zipcode, :business_name)
  end
end
