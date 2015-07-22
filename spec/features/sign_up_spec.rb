require_relative 'acceptance_helper'

feature "User sign-up", %q{
  In order to be able to join to community
  to ask the question
  As an User
  I want to sign up
} do



  scenario "Non-registered user try to sign up" do
    visit new_user_registration_path

    fill_in "Email", with: 'mytest@gmail.com'
    fill_in "Password", with: '12345678'
    fill_in "Password confirmation", with: '12345678'
    click_on "Sign up"
    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(current_path).to eq root_path
  end


given(:user) { create :user }
  scenario "Registered user try to sign up" do
    sign_in(user)
    visit new_user_session_path

    expect(page).to have_content 'You are already signed in.'
    expect(current_path).to eq root_path
  end
end