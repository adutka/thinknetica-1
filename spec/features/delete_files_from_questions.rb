require_relative 'acceptance_helper'

feature 'Delete files from question', %q{
  In order to illustrate my question
  As an question's athor
  I'd like to to delete files
} do

  given(:user) { create(:user) }

  background do
    sign_in(user)
    visit questions_path
  end

  scenario 'user removes files in question', js: true do
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Text text lala'

    4.times {click_on 'Add an attachment'}

    inputs = all('input[type="file"]')
    inputs[0].set("#{Rails.root}/spec/fixtures/1.txt")
    inputs[1].set("#{Rails.root}/spec/fixtures/2.txt")
    inputs[2].set("#{Rails.root}/spec/fixtures/3.txt")
    inputs[3].set("#{Rails.root}/spec/fixtures/4.txt")
    inputs[4].set("#{Rails.root}/spec/fixtures/5.txt")

    click_on 'Create'

    expect(page).to have_link '1.txt'
    expect(page).to have_link '2.txt'
    expect(page).to have_link '3.txt'
    expect(page).to have_link '4.txt'
    expect(page).to have_link '5.txt'
    visit edit_question_path(Question.last.id)
    within 'div', text: '1.txt' do
      click_on 'Remove this attachment'
    end
    expect(page).to_not have_link '1.txt'

  end