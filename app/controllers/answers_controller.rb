
class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :best]
  before_action :load_question_and_answer, only: [:index, :create, :update, :best]

  def index
    # @question = Question.find(params[:question_id])
    @answers = @question.answers.order('best DESC')
  end

  def create
    # @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user

    @message = if @answer.save
      'Your answer successfully created.'
    else
      "Answer body can't be blank."
    end
  end

  def update
    @answer.update(answers_params)
    @question = @answer.question
  end

  def destroy
    @answer = Answer.find(params[:id])
    @question = @answer.question
    if @answer.user_id == current_user.id
      @answer.destroy
      @message = "Your answer successfully deleted."
    else
      @message = "It's impossible to delete the answer"
    end
  end

  def best
    if @question.user == current_user
      @answer.select_best
      @answers = @question.answers
      @message = "The Best answer is #{@answer.body}"
    else
      @message = "This is not your answer"
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def load_question_and_answer
    @question = Question.find(params[:question_id])
    # ap 'params[:id]'
    # ap params[:answer_id]
    id = params[:id] || params[:answer_id]
    # ap id
    @answer = @question.answers.find(id) if id
  end
end
