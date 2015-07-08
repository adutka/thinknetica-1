require_relative 'acceptance_helper'

feature 'View answers in Question', %q{
  In order to find answers in question
  As an user
  I want to be able view list of answers in question
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer1) { create(:answer, question: question) }
  given!(:answer2) { create(:answer, question: question) }

  scenario "User can see answers for question" do
    visit question_path(question)

    question.answers.each do |n|
      expect(page).to have_content(n.body)
    end
  end
end