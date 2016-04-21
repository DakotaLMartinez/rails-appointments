class Appointment < ActiveRecord::Base
  belongs_to :location
  belongs_to :user
  belongs_to :client
  
  def date
    
  end
  
  def client_name 
    client.name
  end
  
  def location_name 
    location.nickname
  end
  
  def appointment_time=(time)
    write_attribute(:appointment_time, parse_time(time) )
  end
  
  def parse_time(hash)
    DateTime.parse(hash["date"] + " " + hash["hour"] + ":" + hash["min"])
  end
  
  ## Validations 
  
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :appointment_time, presence: true 
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true 
  
  include ActiveModel::Validations 
  
  class AppointmentTimeValidator 
    def initialize(appointment)
      @appointment = appointment 
      @user = appointment.user
    end
    
    def validate 
      # selects the user's appointments from yesterday, 
      # today and tomorrow
      appointments = @user.appointments.select { |a| a.appointment_time.midnight == @appointment.appointment_time.midnight || a.appointment_time.midnight == @appointment.appointment_time - 1.day || a.appointment_time.midnight == @appointment.appointment_time + 1.day }
      # makes sure that current appointments don't overlap
      # first checks if an existing appointment is still
      # in progress when the new appointment is set to start
      # next checks if the new appointment would still be in 
      # progress when an existing appointment is set to start
      appointments.each do |appointment| 
        if @appointment != appointment 
          if appointment.appointment_time < @appointment.appointment_time && @appointment.appointment_time < appointment.appointment_time + appointment.duration.seconds || @appointment.appointment_time < appointment.appointment_time && appointment.appointment_time < @appointment.appointment_time + @appointment.duration.seconds
            @appointment.errors.add(:appointment_time, "is not available.")
          end
        end
      end
    end
  end
  
  validate do |appointment| 
    AppointmentTimeValidator.new(appointment).validate
  end
  
end
