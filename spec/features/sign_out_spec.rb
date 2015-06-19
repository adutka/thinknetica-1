require 'rails_helper'

feature 'Sign out', %q{
  In order to be able to secure own account
  As an user
  I want to be able to sign out
} do

  given(:user) { create(:user) }


  scenario 'Authenticated user try to sign out' do
sign_in(user)

    click_on 'Log out'
    expect(page).to have_content 'Signed out successfully.'
    expect(current_path).to eq root_path
  end
end