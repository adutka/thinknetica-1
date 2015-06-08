class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy

  validates :title, length: { in: 3..40 }, presence: true
  validates :body, length: { in: 10..10000 }, presence: true
end
