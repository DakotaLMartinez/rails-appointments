require 'rails_helper'

feature "Appointment Nested Routes", :devise do 
  include AppointmentsAttributeHelper
  
  let(:tomorrow) { tomorrow = DateTime.now + 1.day }
  scenario "Users can create appointments for a particular client from a nested client route" do 
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    new_client = user.clients.create(name: "new client")
    visit new_client_appointment_path(new_client) 
    fill_in "appointment[appointment_time][date]", with: tomorrow.strftime("%m/%d/%Y")
    select "11 AM", from: "appointment_appointment_time_hour"
    click_button "Create Appointment"
    visit client_path(new_client)
    expect(page).to have_content(short_time(Appointment.last))
  end
  
  scenario "Users can create appointments for a particular location from a nested location route" do 
    user = FactoryGirl.create(:user)
    new_location = user.locations.create(nickname: 'my awesome new location')
    signin(user.email, user.password)
    visit new_location_appointment_path(new_location)
    fill_in "appointment_client_attributes_name", with: "awesome new client"
    fill_in "appointment_appointment_time_date", with: tomorrow.strftime("%m/%d/%Y")
    select "12 PM", from: "appointment_appointment_time_hour"
    click_button "Create Appointment"
    visit location_path(new_location)
    expect(page).to have_content(short_time(Appointment.last))
  end
  
    
end