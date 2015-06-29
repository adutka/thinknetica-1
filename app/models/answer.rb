class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates :question_id, presence: true
  validates :body, length: { in: 5..1000 }, presence: true
  validates :user_id, presence: true
end
