class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]
  before_action :load_question, only: [:show, :edit, :update, :destroy ]

  def index
    @questions = Question.all
  end

  def show
    @answers = @question.answers
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = Question.new(question_params)
      if @question.save
        flash[:notice] = 'Created question'
        redirect_to question_path(@question)
      else
        render :new
      end
  end

  def update
    if @question.update(question_params)
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    flash[:notice] = 'Question successfully deleted.'
    redirect_to questions_path
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end

end
