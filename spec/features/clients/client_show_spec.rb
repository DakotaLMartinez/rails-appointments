require 'rails_helper'

feature 'Client Show', :devise do
  
  scenario 'user can see clients they created' do 
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    new_client = user.clients.create(name: "my new client", email: "my@email.com", phone_number: "(310) 111-2222")
    visit client_path(new_client)
    expect(page).to have_content("my new client")
    expect(page).to have_content("my@email.com")
    expect(page).to have_content("(310) 111-2222")
  end
  
  scenario "user cannot see another user's clients" do 
    user = FactoryGirl.create(:user)
    other_user = FactoryGirl.create(:user, email: 'other@email.com')
    signin(user.email, user.password)
    new_client = user.clients.create(name: "my new client", email: "my@email.com", phone_number: "(310) 111-2222")
    click_link "Sign out"
    signin(other_user.email, other_user.password)
    visit client_path(new_client)
    expect(page).not_to have_content("(310) 111-2222")
    expect(page.current_path).to eq(clients_path)
  end
    
end
