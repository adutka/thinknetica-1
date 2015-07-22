require_relative 'acceptance_helper'

feature 'Add files to question', %q{
  In order to illustrate myquestion
  As an question's athor
  I'd like to be able to attach files
} do

  given(:user) { create(:user) }

  background do
    sign_in(user)
    # visit new_question_path
  end

  scenario 'user adds files when ask question' do
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Text text lala'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"

    click_on 'Create'
    expect(page).to have_content 'spec_helper.rb'
  end
end