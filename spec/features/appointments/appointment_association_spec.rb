require 'rails_helper' 

feature "Appointments Associations Spec", :devise do 
  
  scenario "Users can create a new client through the New Appointment Form" do 
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    today = Time.now.strftime("%m/%d/%Y")
    visit new_appointment_path
    fill_in "appointment_client_attributes_name", with: "my awesome new client"
    fill_in "appointment_appointment_time_date", with: today
    select "2 PM", from: "appointment_appointment_time_hour"
    select "00", from: "appointment_appointment_time_min"
    select "1 hr", from: "appointment_duration_hour"
    select "00 min", from: "appointment_duration_min"
    fill_in "appointment_price", with: 60
    click_button "Create Appointment" 
    visit clients_path 
    expect(page).to have_content("my awesome new client")
  end
  
  let(:tomorrow_at_ten) { DateTime.now.midnight + 34.hours }
  
  scenario "users can create new locations from the appointment form" do 
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    new_client = user.clients.create(name: 'my new client')
    new_appointment = user.appointments.create(appointment_time: { "date" => tomorrow_at_ten.strftime("%Y-%m-%d"), "hour" => tomorrow_at_ten.strftime("%l"), "min" => tomorrow_at_ten.strftime("%M") }, duration: 3600, price: 80, client: new_client)
    visit edit_appointment_path(new_appointment)
    fill_in "appointment_location_attributes_nickname", with: "my new awesome home"
    click_button "Update Appointment"
    expect(page).to have_content("my new awesome home")
  end
    
end