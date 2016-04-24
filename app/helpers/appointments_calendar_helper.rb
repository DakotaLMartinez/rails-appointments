module AppointmentsCalendarHelper
  def add_weekly_calendar(appointments)
    render partial: "simple_calendar/weekly_calendar_appointments", locals: { appointments: appointments }
  end
  
  def appointment_position(appointment)
    "top: #{ ( ( (appointment.appointment_time - appointment.appointment_time.midnight)/3600 - 8 ) * 40 ) + 28}px;"
  end
  
  def appointment_height(appointment)
    "height: #{appointment.duration * 40/3600}px;"
  end
  
  def at_location(appointment)
    " at #{appointment.location_name}" if appointment.location
  end
end
