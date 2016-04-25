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
  
  def highlight_appointment(appointment)
    if current_page?( appointment_path(appointment)) || current_page?( edit_appointment_path(appointment) )
      " highlight"
    end
  end
  
  def appointment_text(appointment)
    "<span class='name'>#{appointment.client_name}</span>#{at_location(appointment)}".html_safe
  end
  
  def from_to(appointment)
    "#{appointment.start_time.strftime("%l:%M %p")} - #{appointment.end_time.strftime("%l:%M %p")}"
  end
  
  def date_of_next(day, start_date)
    date = Date.parse(day)
    delta = date >= start_date ? 0 : 7
    date + delta
  end
  
  def date_of_last(day)
    date_of_next(day) - 7.days
  end
end
