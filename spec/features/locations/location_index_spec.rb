require 'rails_helper'

feature "Location index", :devise do 
  
  scenario "users can view locations they created" do 
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    visit new_location_path 
    fill_in "location_nickname", with: "Home!"
    click_button "Create Location"
    visit locations_path 
    expect(page).to have_content("Home!")
  end
  
  scenario "users can't view locations created by other users" do 
    user = FactoryGirl.create(:user)
    other_user = FactoryGirl.create(:user, email: "other@email.com")
    signin(user.email, user.password)
    user.locations.create(nickname: "My private home!")
    click_link "Sign out" 
    signin(other_user.email, other_user.password)
    visit locations_path 
    expect(page).not_to have_content("My private home!")
  end
    
end