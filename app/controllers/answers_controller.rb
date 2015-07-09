
class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def index
    @question = Question.find(params[:question_id])
    @answers = @question.answers
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user

    @message = if @answer.save
      'Your answer successfully created.'
    else
      "Answer body can't be blank."
    end
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

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
