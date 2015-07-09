require_relative 'acceptance_helper'

feature 'User sign in', %q{
  In order to be able to ask question
  As an user
  I want to be able to sign in
  } do

  given(:user) { create(:user) }

  scenario 'Registered user ty to sign in' do
    sign_in(user)

    expect(page).to have_content 'Signed in successfully'
    expect(current_path).to eq root_path
  end

  scenario 'Non registered user ty to sign in' do

    visit new_user_session_path
    fill_in 'Email', with: 'wrong_user@test.com'
    fill_in 'Password', with: '12345678'
    click_button 'Log in'

    expect(page).to have_content 'Invalid email or password'
    expect(current_path).to eq new_user_session_path
  end

end