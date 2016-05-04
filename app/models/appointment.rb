class Appointment < ActiveRecord::Base
  belongs_to :location
  belongs_to :user
  belongs_to :client
  
  accepts_nested_attributes_for :client
  accepts_nested_attributes_for :location
  
  def start_time
    self.appointment_time
  end
  
  def end_time
    appointment_time + duration.seconds
  end
  
  def client_name 
    client.name
  end
  
  def location_name 
    location.nickname if location
  end
  
  ## Form Parsing methods
  
  def client_attributes=(atts)
    if atts[:name] != ""
      self.client = self.user.clients.find_or_create_by(atts)   
    end
  end
  
  def location_attributes=(atts)
    if atts[:nickname] != ""
      location = self.user.locations.find_or_create_by(atts)  
      self.location = location
    end
  end
  
  def appointment_time=(time)
    if time.is_a?(Hash)
      self[:appointment_time] = parse_datetime(time) 
    else
      self[:appointment_time] = time
    end
  end
  
  def parse_date(string)
    array = string.split("/")
    first_item = array.pop
    array.unshift(first_item).join("-")
  end
  
  def parse_datetime(hash)
    if hash["date"].match(/\d{2}\/\d{2}\/\d{4}/)
      Time.zone.parse("#{parse_date(hash["date"])} #{hash["hour"]}:#{hash["min"]}")
    end
  end
  
  def duration=(duration) 
    if duration.is_a?(Hash)
      self[:duration] = parse_duration(duration)
    else 
      self[:duration] = duration
    end
  end
  
  def parse_duration(hash)
    hash["hour"].to_i + hash["min"].to_i
  end
  
  ## Validations 
  
  validates :duration, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :appointment_time, presence: { message: "must be a valid date" }
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true 
  validates :client_id, presence: true
  
  validate :time_still_valid
  
  def time_still_valid
    AppointmentTimeValidator.new(self).validate
  end
  
  include ActiveModel::Validations 
  
  class AppointmentTimeValidator 
    def initialize(appointment)
      @appointment = appointment 
      @user = appointment.user
    end
    
    def validate 
      if @appointment.appointment_time
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
            if appointment.appointment_time <= @appointment.appointment_time && @appointment.appointment_time <= appointment.end_time || @appointment.appointment_time <= appointment.appointment_time && appointment.appointment_time <= @appointment.end_time
              @appointment.errors.add(:appointment_time, "is not available.")
            end
          end
        end
      end
      
    end
    
  end
  
  validate do |appointment| 
    AppointmentTimeValidator.new(appointment).validate
  end
  
end
