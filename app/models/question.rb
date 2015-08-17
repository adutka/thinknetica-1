class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachable
  belongs_to :user

  validates :title, length: { in: 3..40 }, presence: true
  validates :body, length: { in: 3..10000 }, presence: true
  validates :user_id, presence: true

  accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: :all_blank

  has_reputation :votes, source: :user, aggregated_by: :sum

  # has_many :evaluations, class_name: "RSEvaluation", as: :source

  # has_reputation :votes, source: {reputation: :votes, of: "question/answers"}, aggregated_by: :sum


  # def voted_for?(source)
  #   answer.evaluations.where(source_type: "Question", source_id: "question_id/id").present?
  # end
end
