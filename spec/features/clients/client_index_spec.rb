require 'rails_helper'
# Feature: Sign in
#   As a user
#   I want to sign in
#   So I can visit protected areas of the site

feature 'Client Index', :devise do
  
  
  # Scenario: User creates a new client and can see them on the index page
  scenario 'Users can see clients they have created' do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    visit new_client_path 
    fill_in 'client_name', with: "my new client"
    click_button 'Create Client'
    visit new_client_path
    fill_in 'client_name', with: "my second client"
    click_button 'Create Client' 
    visit clients_path 
    expect(page).to have_content('my new client')
    expect(page).to have_content('my second client')

  end
  
  scenario 'Users cannot see clients created by other users' do
    user = FactoryGirl.create(:user)
    other_user = FactoryGirl.create(:user, email: 'other@email.com')
    signin(other_user.email, other_user.password)
    visit new_client_path 
    fill_in 'client_name', with: "my private client"
    click_button 'Create Client'
    click_link "Sign out"
    signin(user.email, user.password)
    visit clients_path
    expect(page).not_to have_content('my private client')

  end

  

end
