module AppointmentsFormHelper
  def appointment_date(appointment)
    if appointment.appointment_time
      appointment.appointment_time.strftime("%Y-%m-%e")
    else
      Time.now.strftime("%Y-%m-%e")
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
    appointment.appointment_time.strftime('%l %p') if appointment.appointment_time
  end
  
  def min_selector(name, appointment)
    min_choices = ["00", "15", "30", "45"]
    select_tag(name, options_for_select(min_choices, appointment_min(appointment) ) )
  end 
  
  def appointment_min(appointment)
    appointment.appointment_time.strftime('%M') if appointment.appointment_time
  end
  
  def duration_field(name)
    options = {
      "30 minutes" => "1800",
      "45 minutes"=> "2700",
      "1 hour" => "3600",
      "1 hour and 15 minutes" => "4500",
      "1 hour and 30 minutes" => "5400"
    }
    select_tag(name, options_for_select(options))
  end
  
  def float_two_decimals(price)
    '%.2f' % price if price
  end
  
  def parse_time(array)
    DateTime.parse(array["date"] + " " + array["hour"] + ":" + array["min"])
  end
  
end
