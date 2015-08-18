require_relative 'acceptance_helper'

feature 'Answer like or dislike', %q{
  I order to mark answer
  As an user
  I want to select good or bad answer
} do

  before(:each) do

  end

  describe "Authenticated user sets reputations for questions" do

    before(:each) do
      @user = User.create!(:email => 'jack@uu.ua', :password => '1234567890')
      @question = Question.create!(:title => 'question1', :body => 'body1?',:user_id => @user.id)
      @answer = @question.answers.create!(:body => 'body1?', question_id: @question, :user_id => @user.id)

      @user2 = User.create(:email => 'dick@uu.ua', :password => '1234567890')
      @user3 = User.create(:email => 'dick3@uu.ua', :password => '1234567890')

    end

    it "return 0 as a default" do
      expect(@answer.reputation_for(:votes)).to eq(0)
    end

    it "return appropriate value in case of valid input UP" do

      @answer.add_or_update_evaluation(:votes, 1, @user2)
      @answer.add_or_update_evaluation(:votes, 1, @user3)
      expect(@answer.reputation_for(:votes)).to eq(2)
    end

    it "return appropriate value in case of valid input DOWN" do
      @answer.add_or_update_evaluation(:votes, -1, @user2)
      @answer.add_or_update_evaluation(:votes, -1, @user3)
      expect(@answer.reputation_for(:votes)).to eq(-2)
    end

    it "cancel votes" do
      @answer.delete_evaluation(:votes, @user2)
      @answer.delete_evaluation(:votes, @user3)
      expect(@answer.reputation_for(:votes)).to eq(0)
    end
  end

  describe "Authenticated user can't sets reputations for owner questions" do
    @user = User.create!(:email => 'jack@uu.ua', :password => '1234567890')

    it "Value of reputation unchanged for owner question" do
      expect(page).to_not have_link ("up")
      expect(page).to_not have_link ("down")
      expect(page).to_not have_link ("cancel_vote")
    end
  end


  describe "Non-authenticated user can't sets reputations for answers" do
    given(:user) { create(:user) }
    given!(:question) { create(:question, user: user) }
    given!(:answers) { create_list(:answer, 3, question: question) }

    it "Value of reputation unchanged for answer" do
      question.answers.each do |n|
        expect(page).to_not have_link ("up")
        expect(page).to_not have_link ("down")
        expect(page).to_not have_link ("cancel_vote")
      end
    end
  end
end