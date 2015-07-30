require_relative 'acceptance_helper'

feature 'Add files to question', %q{
  In order to illustrate myquestion
  As an question's athor
  I'd like to be able to attach files
} do

  given(:user) { create(:user) }

  background do
    sign_in(user)
    visit questions_path
  end

  scenario 'user adds file when ask question' do
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Text text lala'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"

    click_on 'Create'
    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end

  scenario 'user adds files when ask question', js: true do
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Text text lala'

    click_on 'Add an attachment'

    inputs = all('input[type="file"]')
    inputs[0].set("#{Rails.root}/spec/spec_helper.rb")
    inputs[1].set("#{Rails.root}/spec/rails_helper.rb")

    click_on 'Create'
    expect(page).to have_link 'spec_helper.rb'
    expect(page).to have_link 'rails_helper.rb'
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
end