class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
    
  def index 
    @appointments = current_user.appointments
  end 
  
  def show 
    
  end
  
  def new 
    @appointment = current_user.appointments.build
  end
  
  def create 
    @appointment = Appointment.new(appointment_params.merge(user_id: current_user.id))
    if @appointment.valid?
      @appointment.save
      redirect_to appointment_path(@appointment)
    else 
      @appointment.user = nil
      render :new
    end
  end
  
  def edit 
  end
  
  def update 
    if @appointment.update(appointment_params)
      redirect_to appointment_path(@appointment)
    else 
      render :edit
    end
  end
  
  def destroy 
    @appointment.destroy 
    redirect_to appointments_path
  end
  
  private 
  
  def set_appointment
    @appointment = current_user.appointments.find_by(id: params[:id])
    if @appointment.nil? 
      flash[:error] = "Appointment not found."
      redirect_to appointments_path
    end
  end
  
  def appointment_params
    time_keys = params[:appointment].try(:fetch, :appointment_time, {}).keys
    params.require(:appointment).permit(:client_id, :duration, :price, :location_id, location_attributes: [:nickname], client_attributes: [:name], appointment_time: time_keys)
  end
  
end
