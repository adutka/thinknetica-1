class Answer < ActiveRecord::Base
  has_many :attachments, as: :attachable

  belongs_to :question
  belongs_to :user

  validates :question_id, presence: true
  validates :body, length: { in: 5..1000 }, presence: true
  validates :user_id, presence: true

  accepts_nested_attributes_for :attachments

  default_scope {order('best DESC')}

  def select_best
    question.answers.update_all(best: false)
    update!(best: true)
  end
end
