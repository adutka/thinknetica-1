require_relative "acceptance_helper"

feature "Author choose best answer", %q{
  In order to select best solution
  As an author of question
  I want to be able set the best answer
  } do

  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question) }
  given!(:best_answer) { create(:answer, question: question, user: user, best: true) }
  given!(:other_answer) { create(:answer, question: question) }
  given!(:non_owner) { create(:user) }

  describe "Owner of question", js: true  do
    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario "sees link to select best answer" do
      expect(page).to have_link('Best answer')
    end

    scenario "Author of question sets best answer"do
      click_link('Best answer')
      expect(page).to have_link('Best answer')
    end

    scenario "unselect best answer" do
      expect(page).to have_link('Cancel Best answer')
    end

    scenario "sorting answers" do
        expect(page).to have_content best_answer.body
        expect(page).to have_content answer.body
        expect(page).to have_content other_answer.body

    end
  end

  describe "Non-owner of answer", js: true do
    before do
      sign_in(non_owner)
      visit question_path(question)
    end

    scenario "tries to select best answer" do
      expect(page).to_not have_link('Best answer')
    end
  end


end