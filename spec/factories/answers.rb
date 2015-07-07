FactoryGirl.define do
  sequence :body do |n|
    "My answer lalala#{n}"
  end
  factory :answer do
    body
    question
    user
  end

  factory :invalid_answer, class: 'Answer' do
    body nil
    question
  end
end