require 'rails_helper'

feature 'create answer to question', %q{
  In order to answer to a question
  As an user
  I want to answer question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:answer) { build(:answer) }

  scenario 'Authenticated user creates answer' do
    sign_in(user)

    visit questions_path
    save_and_open_page
    fill_in 'Body', with: 'MyText-MyText'
    click_on 'Create'
    expect(page).to have_content 'Your answer successfully created.'
    expect(current_path).to eq question_path (question)

  end
end