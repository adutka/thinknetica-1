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

    visit question_path (question)
    fill_in 'answer[body]', with: 'Some Answer body'
    click_on 'To Answer'
    expect(page).to have_content 'Your answer successfully created.'
    expect(current_path).to eq question_path (question)
  end
end