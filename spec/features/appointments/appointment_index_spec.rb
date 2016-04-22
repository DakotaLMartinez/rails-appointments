require 'rails_helper' 

feature 'Appointments Index', :devise do 
  
  scenario 'users can see appointments created with a certain client' do 
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    new_client = user.clients.create(name: 'my new client')
    today = Time.now.strftime("%Y-%m-%d")
    visit new_appointment_path
    select 'my new client', from: 'appointment_client_id'
    fill_in "appointment_appointment_time_date", with: today
    select "12 PM", from: "appointment_appointment_time_hour"
    select "00", from: "appointment_appointment_time_min"
    select "1 hour", from: "appointment_duration"
    fill_in "appointment_price", with: 60
    click_button "Create Appointment" 
    expect(page).to have_content("my new client")
    expect(page).to have_content(Time.now.strftime("%A %B %e"))
    expect(page).to have_content("1 hour")
    expect(page).to have_content("$60.00")
  end
  
  scenario 'user can create a new client while creating an appointment' do 
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    new_client = user.clients.create(name: 'my new client')
    today = Time.now.strftime("%Y-%m-%d")
    visit new_appointment_path
    fill_in "appointment_client_attributes_name", with: "my awesome second client"
    fill_in "appointment_appointment_time_date", with: today
    select "2 PM", from: "appointment_appointment_time_hour"
    select "00", from: "appointment_appointment_time_min"
    select "1 hour", from: "appointment_duration"
    fill_in "appointment_price", with: 60
    click_button "Create Appointment" 
    expect(page).to have_content("my awesome second client")
    expect(page).to have_content(Time.now.strftime("%A %B %e"))
    expect(page).to have_content("1 hour")
    expect(page).to have_content("$60.00")
  end
  
  scenario "users cannot see appointments created by other users" do 
    user = FactoryGirl.create(:user)
    other_user = FactoryGirl.create(:user, email: "other@email.com")
    signin(user.email, user.password)
    new_client = user.clients.create(name: 'my new client')
    today = Time.now.strftime("%Y-%m-%d")
    visit new_appointment_path
    select 'my new client', from: 'appointment_client_id'
    fill_in "appointment_appointment_time_date", with: today
    select "12 PM", from: "appointment_appointment_time_hour"
    select "00", from: "appointment_appointment_time_min"
    select "1 hour", from: "appointment_duration"
    fill_in "appointment_price", with: 60
    click_button "Create Appointment" 
    click_link "Sign out"
    signin(other_user.email, other_user.password)
    visit appointments_path 
    expect(page).not_to have_content('my new client')
  end
   
end