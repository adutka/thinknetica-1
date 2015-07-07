require 'rails_helper'

describe QuestionsController do
  let(:question) { create(:question) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }

    before do
      get :index
    end

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(:response).to render_template :index
    end
  end

  describe 'GET #show' do
    before do
      get :show, id: question
    end

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders show view' do
      expect(:response).to render_template :show
    end
  end

  describe 'GET #new' do
    sign_in
    before do
      get :new
    end


    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new view' do
      expect(:response).to render_template :new
    end
  end


  describe 'GET #edit' do
    sign_in
    before do
      get :edit, id: question
    end

    it 'assigns a edit requested question to @question' do
expect(assigns(:question)).to eq question
    end

    it'renders edit view' do
      expect(:response).to render_template :edit
    end
  end

  describe 'POST #create' do
    sign_in
    # let(:question) { create(:question) }

    context 'with valid attributes' do
      it 'saves the new question in the database' do
        expect { post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
      end

      it 'belongs to user' do
        post :create, question: attributes_for(:question)
        expect(assigns(:question).user_id).to eq subject.current_user.id
      end

      it 'redirects to show view' do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'doesn"t save the question' do
        expect { post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
      end

      it 're-renders new view' do
        post :create, question: attributes_for(:invalid_question)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    sign_in
    context 'with valid attributes' do
      it 'saves the new question in the database' do
        patch :update, id: question, question: attributes_for(:question)
        expect(assigns(:question)).to eq question
      end
      it 'change question attributes' do
        patch :update, id: question, question: { title: 'new title', body: 'new body' }
        question.reload
        expect(question.title).to eq 'new title'
        expect(question.body).to eq 'new body'
      end
      it 'redirect to updated question' do
        patch :update, id: question, question: attributes_for(:question)
        expect(response).to redirect_to question_path
      end
    end

    context 'with invalid attributes' do

      it 'does not change question attributes' do
        patch :update, id: question, question: { title: 'new title', body: nil }
        question.reload
        expect(question.title).to eq question.title
        expect(question.body).to eq question.body
      end

      it 're-renders edit view' do
        patch :update, id: question, question: { title: 'new title', body: nil }
        expect(:response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in

    context 'own question' do
      before { question.update_attribute(:user, @user) }

      it 'deletes question' do
        expect { delete :destroy, id: question}.to change(Question, :count).by(-1)
      end

      it 'redirects to questions_path' do
        delete :destroy, id: question
        expect(response).to redirect_to questions_path
      end
    end

    context 'somebody\'s else question' do
      let(:another_user) { create(:user) }
      let(:another_user_question) { create(:question, user: another_user) }

      it 'doesn\'t delete question' do
        another_user_question
        expect { delete :destroy, id: another_user_question }.not_to change(Question, :count)
      end

      it 'redirects to question_path' do
        delete :destroy, id: another_user_question
        expect(response).to redirect_to question_path
      end
    end
  end
end