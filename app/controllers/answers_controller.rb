class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    # @answer.user = current_user
    if @answer.save
      redirect_to @question
      flash[:notice] = 'Your answer successfully created.'
    else
      render 'questions/show'
    end
  end


  def destroy
    @answer = Answer.find(params[:id])
    @question = @answer.question

    if @answer.destroy
      redirect_to question_path(@question), notice: "Your answer successfully deleted."
    else
      redirect_to @question, alert: "It's not your answer!"
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :question_id)
  end
end
