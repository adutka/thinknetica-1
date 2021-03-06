require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should have_many(:answers) }
  it { should have_many(:attachments) }
  it { should belong_to(:user) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should validate_presence_of :user_id }

  it { should validate_length_of(:title).is_at_least(3).is_at_most(40) }
  it { should validate_length_of(:body).is_at_least(3).is_at_most(10000) }

  it { should accept_nested_attributes_for :attachments }
end