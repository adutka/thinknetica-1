require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to :user }
  it { should belong_to :question }

  it { should validate_presence_of :user_id }
  it { should validate_presence_of :question_id }
  it { should validate_presence_of :body }

  it { should validate_length_of(:body).is_at_least(5).is_at_most(1000) }
end

  describe "#select best" do
    let(:question) { create(:question) }
    let(:answer) { create(:answer, question: question) }

    it "answer select_best" do
      answer.select_best
      expect(answer.reload.best).to be_truthy
    end

    it "false other answer" do
      other_answer = create(:answer, question: question, best: true)
      answer.select_best
      expect(other_answer.reload.best).to be false
    end
  end

