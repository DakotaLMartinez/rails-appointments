module AppointmentsFormHelper
  def client_fields(form, appointment, client)
    if client
      output = [content_tag(:h3, "with #{client.name}"), hidden_field_tag("appointment[client_id]", client.id)]
      safe_join(output)
    else
      render partial: "client_fields", locals: { f: form, appointment: appointment }
    end
  end
  
  def location_fields(form, appointment, location)
    if location 
      output = [content_tag(:h3, "at #{location.nickname}"), hidden_field_tag("appointment[location_id]", location.id)]
      safe_join(output)
    else 
      render partial: "location_fields", locals: { f: form, appointment: appointment }
    end
  end
  
  def appointment_date(appointment)
    if appointment.appointment_time
      appointment.appointment_time.strftime("%m/%d/%Y")
    else
      Time.zone.now.strftime("%m/%d/%Y")
    end
  end
  
  def hour_selector(name, appointment)
    time_choices = {
     "8 AM" => 8, 
     "9 AM" => 9, 
     "10 AM" => 10, 
     "11 AM" => 11, 
     "12 PM" => 12, 
     "1 PM" => 13,
     "2 PM" => 14,
     "3 PM" => 15,
     "4 PM" => 16,
     "5 PM" => 17,
     "6 PM" => 18,
     "7 PM" => 19,
     "8 PM" => 20,
    }
    select_tag(name, options_for_select(time_choices, time_choices[appointment_hour(appointment)] ) )
  end
  
  def appointment_hour(appointment)
    if appointment.appointment_time
      appointment.appointment_time.strftime('%l %p').strip 
    else
      "8 AM"
    end
  end
  
  def min_selector(name, appointment)
    min_choices = ["00", "15", "30", "45"]
    select_tag(name, options_for_select(min_choices, appointment_min(appointment) ) )
  end 
  
  def appointment_min(appointment)
    if appointment.appointment_time
      appointment.appointment_time.strftime('%M') 
    else
      "00"
    end
  end
  
  def duration_hour_field(name, appointment)
    options = {
      "0 hr" => "0",
      "1 hr" => "3600",
      "2 hr" => "7200", 
      "3 hr" => "10800"
    }
    select_tag(name, options_for_select(options, get_duration_hour(appointment) ) )
  end
  
  def duration_minute_field(name, appointment)
    options = {
      "00 min" => "0",
      "15 min" => "900", 
      "30 min" => "1800", 
      "45 min" => "2700"
    }
    select_tag(name, options_for_select(options, get_duration_min(appointment) ) )
  end
  
  def get_duration_hour(appointment)
    if appointment.duration 
      ((appointment.duration/3600)*3600)
    else 
      0
    end
  end
  
  def get_duration_min(appointment)
    if appointment.duration 
      (appointment.duration % 3600)
    else 
      1800
    end
  end
  
  def float_two_decimals(price)
    '%.2f' % price if price
  end
  
  # def parse_time(array)
  #   DateTime.parse(array["date"] + " " + array["hour"] + ":" + array["min"])
  # end
  
end
