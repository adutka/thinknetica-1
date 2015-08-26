class Answer < ActiveRecord::Base
  include Votable

  has_many :attachments, as: :attachable

  belongs_to :question
  belongs_to :user

  validates :question_id, presence: true
  validates :body, length: { in: 5..1000 }, presence: true
  validates :user_id, presence: true

  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true



  def select_best
    question.answers.update_all(best: false)
    update!(best: true)
  end

end
