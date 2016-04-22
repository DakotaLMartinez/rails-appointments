require 'rails_helper' 

feature "Appointments Associations Spec", :devise do 
  
  scenario "Users can create a new client through the New Appointment Form" do 
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    today = Time.now.strftime("%Y-%m-%d")
    visit new_appointment_path
    fill_in "client_name", with: "my awesome new client"
    fill_in "appointment_appointment_time_date", with: today
    select "2 PM", from: "appointment_appointment_time_hour"
    select "00", from: "appointment_appointment_time_min"
    select "1 hour", from: "appointment_duration"
    fill_in "appointment_price", with: 60
    click_button "Create Appointment" 
    visit clients_path 
    expect(page).to have_content("my awesome new client")
  end
    
end