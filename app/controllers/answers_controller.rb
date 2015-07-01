
class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    if @answer.save
      flash[:notice] = 'Your answer successfully created.'
      redirect_to @question

    else
      flash[:notice] = "Answer body can't be blank."
      render 'questions/show'
    end
  end


  def destroy
    @answer = Answer.find(params[:id])
    @question = @answer.question
    if @answer.user_id == current_user.id
      @answer.destroy
      redirect_to question_path(@question), notice: "Your answer successfully deleted."
    else
      redirect_to @question, alert: "It's impossible to delete the answer"
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
