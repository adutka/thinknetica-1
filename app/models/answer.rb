class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates :question_id, presence: true
  validates :body, length: { in: 5..1000 }, presence: true
  validates :user_id, presence: true

  def select_best
    question.answers.update_all(best: false)
    update!(best: true)
  end

  def cancel_best
    update!(best: false)
  end
end
