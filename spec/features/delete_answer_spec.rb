
require 'rails_helper'

feature 'delete answer in question', %q{
  In order to remove my answer in question
  As an author
  I want to delete answer in question
} do

  given(:user) { create(:user) }
  given!(:answer) { create(:answer, user: user) }

  scenario 'authenticated user can delete his answer' do
    sign_in(answer.user)

    visit question_path(answer.question)
    # byebug
    # 1==1
    save_and_open_page
    click_link 'Delete answer'

    expect(page).to have_content 'Your answer successfully deleted.'
    expect(page).to_not have_content(answer.body)
  end
end