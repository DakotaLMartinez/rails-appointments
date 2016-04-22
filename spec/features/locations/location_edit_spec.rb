require 'rails_helper'

feature "Location Edit", :devise do
  
  scenario "Users can edit locations they created" do 
    user = FactoryGirl.create(:user)
    new_location = user.locations.create(nickname: "Home!")
    signin(user.email, user.password)
    visit edit_location_path(new_location)
    fill_in "location_nickname", with: "My New Home!"
    fill_in "location_street_address", with: "251 Home Way"
    fill_in "location_city", with: "Los Angeles"
    fill_in "location_state", with: "California"
    fill_in "location_zipcode", with: "99999"
    fill_in "location_business_name", with: "SandraKotaVille"
    click_button "Update Location"
    expect(page).to have_content("My New Home!")
    expect(page).to have_content("251 Home Way")
    expect(page).to have_content("Los Angeles")
    expect(page).to have_content("California")
    expect(page).to have_content("99999")
    expect(page).to have_content("SandraKotaVille")
      
  end
  
  scenario "Users can't edit locations created by other users" do 
    user = FactoryGirl.create(:user)
    new_location = user.locations.create(nickname: "Home!")
    other_user = FactoryGirl.create(:user, email: "other@email.com")
    signin(other_user.email, other_user.password)
    visit edit_location_path(new_location)
    expect(page.current_path).to eq(locations_path)
  end
    
end