class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
has_many :questions
has_many :answers

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

has_many :evaluations, class_name: "RSEvaluation", as: :source

has_reputation :votes, source: {reputation: :votes, of: :questions}, aggregated_by: :sum

  def voted_for?(question)
    evaluations.where(target_type: question.class, target_id: question.id).present?
  end


end
