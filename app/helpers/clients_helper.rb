module ClientsHelper
  def client_email(client)
    client.email if client.email != ""
  end
  
  def client_phone(client)
    if client.phone_number && client.phone_number != ""
      number_array = client.phone_number.gsub(/\D/, '').split(//)  
      "(#{number_array[0,3].join}) #{number_array[3,3].join}-#{number_array[6,4].join}"
    end
  end
  
  def client_name(client)
    if current_page?(clients_path)
      link_to client.name, client_path(client)
    else
      client.name
    end
  end
  
  def client_value(client)
    number_to_currency(client.value) if client.value != 0
  end
  
  def appointment_count(client)
    link_to "Total Appointments: #{client.appointment_count}", client_path(client)
  end
  
end
