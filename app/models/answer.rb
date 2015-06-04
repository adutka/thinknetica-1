class Answer < ActiveRecord::Base
  belongs_to :question

  validates :question_id, presence: true
  validates :body, length: { in: 5..1000 }, presence: true
end
