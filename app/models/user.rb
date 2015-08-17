class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
has_many :questions
has_many :answers

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

has_many :evaluations, class_name: "RSEvaluation", as: :source

has_reputation :votes, source: [{reputation: :votes, of: :questions}, {reputation: :votes, of: :answers}], aggregated_by: :sum

# has_reputation :votes, source: {reputation: :votes, of: :answers}, aggregated_by: :sum


  def voted_for?(res)
    res.evaluations.where(source_type: "User", source_id: id).present?
  end
end
