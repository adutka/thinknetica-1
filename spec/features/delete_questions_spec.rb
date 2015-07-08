require_relative 'acceptance_helper'

feature 'delete question', %q{
  In order to delete question
  As an author
  I want to delete question
} do

  given(:user) { create(:user) }
  given(:non_author) { create(:user) }
  given(:question) { create(:question, user: user) }

  scenario 'Authenticated user can delete his question' do
    sign_in(user)

    visit question_path(question)
    click_on 'Delete question'
    expect(page).to have_content 'Question successfully deleted.'
    expect(page).to_not have_content(question.title)
  end

  scenario 'Non-author of the question tries to delete question' do
    sign_in(non_author)
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to_not have_link 'Delete question'
  end

  scenario 'Non-authenticated user tries to delete question' do
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to_not have_link 'Delete question'
  end
end