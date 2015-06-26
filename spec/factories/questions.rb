FactoryGirl.define do
  # sequence :title do |n|#позволяет последовательно генерировать уникальные значения.  числовой параметр, кот увеличивается на 1 каждый раз, когда вызвется последовательность
  #   "MyTitle#{n}"
  # end

  factory :question do
    title "MyTitle"
    body "My question lalala"
    user
  end

  factory :invalid_question, class: 'Question' do
    title nil
    body nil
  end
end
