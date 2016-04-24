module AppointmentsAttributeHelper
  def full_time(appointment)
    "#{appointment.appointment_time.strftime("%A %B %e %l:%M %p")} - #{end_time(appointment)}"
  end
  
  def short_time(appointment)
    appointment.appointment_time.strftime("%b %d, %l:%M %p ")
  end
  
  def end_time(appointment)
    appointment.end_time.strftime("%l:%M %p")
  end
  
  def show_duration(appointment)
    options = {
      1800 => "30 Minutes", 
      2700 => "45 Minutes", 
      3600 => "1 hour", 
      4500 => "1 hour and 15 minutes",
      5400 => "1 hour and 30 minutes"
    }
    options[appointment.duration.to_i]
  end
  
  def show_price(appointment)
    content_tag(:p, number_to_currency(appointment.price) )
  end
  
  def show_location(appointment)
    content_tag(:p, appointment.location_name )
  end
  
  
end
