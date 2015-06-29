require 'rails_helper'

feature 'create answer to question', %q{
  In order to answer to a question
  As an user
  I want to answer question
} do

  given(:user) { create(:user) }
  given(:question) { create :question }
  given(:answer) { build(:answer) }

  scenario 'Authenticated user creates answer' do
    sign_in(user)

    visit question_path (question)
    fill_in 'answer[body]', with: 'Some Answer body'
    click_on 'To Answer'
    expect(page).to have_content 'Your answer successfully created.'
    question.answers.each do |qa|
      expect(page).to have_content(qa.body)
    end
    expect(current_path).to eq question_path (question)
  end

  scenario 'non-authenticated user tries to create answer' do
    visit question_path(question)
    fill_in 'answer[body]', with: 'Some Answer body'
    click_on 'To Answer'

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(page).to have_content 'Log in'
  end

   scenario 'Authenticated user tries to create wrong answer' do
    sign_in(user)

    visit question_path(question)
    fill_in 'answer[body]', with: ''
    click_on 'To Answer'
    expect(current_path).to eq question_answers_path(question)
    expect(page).to have_content "Answer body can't be blank."
  end
end