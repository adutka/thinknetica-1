require_relative 'acceptance_helper'

feature 'Add files to answer', %q{
  In order to illustrate my answer
  As an answer's athor
  I'd like to be able to attach files
} do

  given(:user) { create(:user) }
  given(:question) { create(:question)}

  background do
    sign_in(user)
    visit question_path (question)
  end

  scenario 'user adds files to answer', js: true do
    fill_in 'answer[body]', with: 'Some Answer body'

    click_on 'Add an attachment'

    inputs = all('input[type="file"]')
    inputs[0].set("#{Rails.root}/spec/spec_helper.rb")
    inputs[1].set("#{Rails.root}/spec/rails_helper.rb")

    click_on 'To Answer'
    expect(page).to have_link 'spec_helper.rb'
    expect(page).to have_link 'rails_helper.rb'
  end
end