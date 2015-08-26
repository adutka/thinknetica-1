class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :questions
  has_many :answers
  has_many :votes, dependent: :destroy, as: :votable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
