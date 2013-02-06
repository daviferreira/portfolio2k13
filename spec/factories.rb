FactoryGirl.define do
  factory :user do
    name     "Example User"
    email    "user@example.com"
    password "foobar"
  end

  sequence :email do |n|
    "person-#{n}@example.com"
  end

  sequence :name do |n|
    "Person #{n}"
  end
end
