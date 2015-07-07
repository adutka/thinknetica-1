FactoryGirl.define do
  sequence :email do |n|#позволяет последовательно генерировать уникальные значения.  числовой параметр, кот увеличивается на 1 каждый раз, когда вызвется последовательность
    "user#{n}@test.com"
  end
  factory :user do
    email
    password '12345678'
    password_confirmation '12345678'
  end

end
