require "rails_helper" 

feature "Client Edit", :devise do 
  
  scenario 'users can edit clients they created' do 
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    new_client = user.clients.create(name: "my new client")
    visit edit_client_path(new_client)
    fill_in "client_name", with: "my super cool new client"
    click_button "Update Client"
    expect(page.current_path).to eq(client_path(new_client))
    expect(page).to have_content('my super cool new client')
  end
  
  scenario "users cannot edit other user's clients" do 
    user = FactoryGirl.create(:user)
    other_user = FactoryGirl.create(:user, email: "other@email.com")
    signin(user.email, user.password)
    new_client = user.clients.create(name: "my new client")
    visit edit_client_path(new_client)
    fill_in "client_name", with: "my super cool new client"
    click_button "Update Client"
    click_link "Sign out" 
    signin(other_user.email, other_user.password)
    visit edit_client_path(new_client)
    expect(page.current_path).to eq(clients_path)
    expect(page).not_to have_content('my super cool new client')
  end
  
end