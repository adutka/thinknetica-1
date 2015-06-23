require 'rails_helper'

feature 'View answers in Question', %q{
  In order to find answers in question
  As an user
  I want to be able view list of answers in question
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question) }

  scenario "User can see answers for question" do
    visit questions_path

    question.answers.each do |n|
      expect(page).to have_content(n.body)
      # save_and_open_page
    end
  end
end