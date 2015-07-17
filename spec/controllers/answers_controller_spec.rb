require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }

  before { sign_in(user) }

  describe 'POST #create' do


    context 'with valid attributes' do
      # let(:answer) { question.answers.create(attributes_for(:answer)) }

      it 'saves the new answer in the database' do
        expect { post :create, question_id: question, answer: attributes_for(:answer), format: :js }.to change(question.answers, :count).by(1)
      end

      it 'belongs to user' do
        post :create, question_id: question.id, answer: attributes_for(:answer), format: :js
        expect(assigns(:answer).user_id).to eq subject.current_user.id
      end

      it 'render create template' do
        post :create, question_id: question, answer: attributes_for(:answer), format: :js
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      it 'does not saves the new answer in the database' do
        expect { post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js }.to_not change(question.answers, :count)
      end

      it 'new answer does not exist' do
        expect { post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js }.to_not change(Answer, :count)
      end

      it 'redirects to show view' do
        post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js
        expect(response).to render_template 'answers/create'
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'own answer' do
    sign_in
    before { answer.update_attribute(:user_id, @user.id) }

      it 'removes answer from the database' do
        expect { delete :destroy, question_id: question, id: answer, format: :js }.to change(Answer, :count).by(-1)
      end

      it 're-renders question :show view' do
        delete :destroy, question_id: question, id: answer, format: :js
        expect(response).to render_template 'answers/destroy'
      end
    end

    context 'somebody\'s answer' do
      let(:another_user) { create(:user) }
      let(:another_user_answer) { create(:answer, user: another_user, question: question) }

      it 'does not remove question from the database' do
        another_user_answer
        expect do
          delete :destroy, question_id: question, id: another_user_answer, format: :js
        end.not_to change(Answer, :count)
      end

      it 'rerenders question :show view' do
        delete :destroy, question_id: question, id: another_user_answer, format: :js
        expect(response).to render_template 'answers/destroy'
      end
    end
  end

  describe "POST #best" do
    let!(:owner) { create(:user) }
    let!(:question) { create(:question, user: owner) }
    let!(:answer) { create(:answer, question: question) }

    context "onwer select best answer" do

      it "best answer" do
        sign_in(owner)
        post :best, question_id: question, answer_id: answer, format: :js
        expect(response).to render_template 'answers/best'
        expect(answer.reload.best).to be true
      end
    end

    context "non-onwer select best answer" do

      let!(:non_owner) { create(:user) }

      it "answer is not selected as best" do
        sign_in(non_owner)
        post :best, question_id: question, answer_id: answer, format: :js
        expect(answer.reload.best).to be false
      end
    end
  end
end