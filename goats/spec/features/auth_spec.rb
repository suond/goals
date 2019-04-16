require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content("This is the new user page")
  end

  feature 'signing up a user' do
    before(:each) do
        user = create(:user)
        login_user(user)
    end
    
    scenario 'shows email on the homepage after signup' do
        expect(page).to have_content("Welcome to the index page")  
    end

  end
end

feature 'logging in' do
    given(:user) {create(:user_fk)}
  scenario 'shows username on the homepage after login' do
    login_user(user)
    expect(page).to have_content(user.email)
  end

end

feature 'logging out' do
  scenario 'begins with a logged out state' do
    visit new_session_url
    expect(page).to have_content("Login")
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    expect(page).not_to have_content(user.email)
  end
end