require_relative 'acceptance_helper'

feature 'Question like or dislike', %q{
  I order to mark question
  As an user
  I want to select good or bad question
} do

  given(:users){ create_list(:user, 2) }
  given!(:question){ create(:question, user: users[0]) }

  scenario 'User try to like or dislike owner question' do

    sign_in(users[0])
    visit questions_path
    # byebug
    within ".votes" do
      expect(page).to have_link 'Like'
      expect(page).to have_link 'Dislike'
    end

  end

  scenario 'User try to like other\'s question' do

    sign_in(users[1])
    visit questions_path

    within '.votes' do
      click_on 'Like'
      # expect(page).to_ have_content 'Likes: 1'
    end

  end

  scenario 'User try to dislike other\'s question' do

    sign_in(users[1])
    visit question_path(question)

    within '.votes' do
      click_on 'Dislike'
      # expect(page).to have_content 'Likes: -1'
    end

  end

  scenario 'Non-authenticated user try to like or dislike question' do

      visit question_path(question)

      within '.votes' do
        expect(page).to_not have_link 'Like'
        expect(page).to_not have_link 'Dislike'
      end
  end
end