require_relative 'acceptance_helper'

feature 'Delete files from answer', %q{
  In order to illustrate my answer
  As an answer's athor
  I'd like to delete files
} do

  given(:user) { create(:user) }
  given(:question) { create(:question)}

  background do
    sign_in(user)
    visit question_path (question)
  end

  scenario 'user removes files in answer', js: true do
    fill_in 'answer[body]', with: 'Some Answer body'

    4.times {click_on 'Add an attachment'}

    inputs = all('input[type="file"]')
    inputs[0].set("#{Rails.root}/spec/fixtures/1.txt")
    inputs[1].set("#{Rails.root}/spec/fixtures/2.txt")
    inputs[2].set("#{Rails.root}/spec/fixtures/3.txt")
    inputs[3].set("#{Rails.root}/spec/fixtures/4.txt")
    inputs[4].set("#{Rails.root}/spec/fixtures/5.txt")

    click_on 'To Answer'

    expect(page).to have_link '1.txt'
    expect(page).to have_link '2.txt'
    expect(page).to have_link '3.txt'
    expect(page).to have_link '4.txt'
    expect(page).to have_link '5.txt'

    visit edit_question_answer_path(Question.last.id, Answer.last.id)
    within 'div', text: '1.txt' do
      click_on 'Remove this attachment'
    end
    expect(page).to_not have_link '1.txt'
  end
end