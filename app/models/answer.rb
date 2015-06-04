class Answer < ActiveRecord::Base
  belongs_to :question

  validates :body, :question_id, length: { in: 5..1000 }, presence: true
end
