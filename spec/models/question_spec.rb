require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should have_many(:answers).dependent(:delete_all) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  it { should validate_length_of(:title).is_at_least(3).is_at_most(40) }
  it { should validate_length_of(:body).is_at_least(10).is_at_most(10000) }

end
