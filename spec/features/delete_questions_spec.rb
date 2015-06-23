require 'rails_helper'

feature 'delete question', %q{
  In order to delete question
  As an author
  I want to delete question
} do

  given(:user) { create(:user) }
  # given(:user1) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user can delete his question' do
    sign_in(user)

    visit question_path(question)
    click_on 'Delete question'
    expect(page).to have_content 'Question successfully deleted.'
    expect(page).to_not have_content(question.title)
  end
end