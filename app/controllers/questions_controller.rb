class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :vote ]
  before_action :load_question, only: [:show, :edit, :update, :destroy, :vote ]

  def index
    # @questions = Question.all
    @questions = Question.find_with_reputation(:votes, :all, order: 'votes DESC')
  end

  def show
    ap 'show'
    @answers = @question.answers.order('best DESC')
    @answer = Answer.new
    @attachments = @answer.attachments.build
  end

  def new
    @question = Question.new
    @attachments = @question.attachments.build #create new object in array question
  end

  def edit
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
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
      if @question.user_id == current_user.id
        @question.destroy
        flash[:notice] = 'Question successfully deleted.'
        redirect_to questions_path
      else
        redirect_to @question, alert: "It's impossible to delete this question"
      end
  end



  def vote
    if @question.user_id == current_user.id
      value = params[:type] == "up" ? 1 : -1
      @question.add_or_update_evaluation(:votes, value, current_user)
      redirect_to :back, notice: "Thank you for voting!"
    else
      redirect_to :back, notice: "Unable to vote!"
    end
  end

  def cancel_vote
    if current_user && current_user.voted_for?(question)
      value = default
      @question.add_or_update_evaluation(:votes, value, current_user)
      redirect_to :back, notice: "Vote canceled!"
    else
      redirect_to :back, notice: "Unable to cancel vote!"
    end
  end



  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:id, :file, :_destroy ])
  end

end