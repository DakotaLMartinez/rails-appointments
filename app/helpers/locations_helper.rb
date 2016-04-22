module LocationsHelper
  def show_street_address(location)
    location.street_address if location.street_address
  end
  
  def city_state_zip(location)
    "#{location.city}, #{location.state} #{location.zipcode}" if location.state && location.zipcode
  end
  
  def show_nickname(location)
    if current_page?(location_path(location))
      location.nickname
    else 
      link_to location.nickname, location_path(location)
    end
  end
  
  def show_address(location)
    if current_page?(location_path(location))
      render partial: "address", locals: { location: location }
    end
  end
  
  def edit_delete_links(location)
    output = [
      link_to("Edit", edit_location_path(location)),
      link_to("Delete", location, method: :delete, data: { confirm: "Are you sure you really want to delete this location" })
    ]
    safe_join(output, ", ")
  end
  
  
end
