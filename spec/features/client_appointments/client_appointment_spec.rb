require 'rails_helper' 

feature 'Client Appointments Index', :devise do 
  
  scenario 'users can see appointments created with a certain client' do 
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    new_client = user.clients.create(name: 'my new client')
    today = Time.now.strftime("%Y-%m-%d")
    visit new_client_appointment_path(new_client)
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
   
end