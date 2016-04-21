class AppointmentsController < ApplicationController
  before_action :authenticate_user!
    
  def index 
    
  end 
  
  def show 
    @appointment = Appointment.find(params[:id])
  end
  
  def new 
    @appointment = Appointment.new
  end
  
  def create 
    @appointment = Appointment.new(appointment_params)
    @appointment.user = current_user
    if @appointment.save
      redirect_to appointment_path(@appointment)
    else 
      render :new
    end
  end
  
  private 
  
  def appointment_params
    time_keys = params[:appointment].try(:fetch, :appointment_time, {}).keys
    params.require(:appointment).permit(:client_id, :duration, :price, appointment_time: time_keys)
  end
  
  def new_client_params
    params.require(:client).permit(:name)
  end
  
  def parse_time(array)
    DateTime.parse(array["date"] + " " + array["hour"] + ":" + array["min"])
  end
end
