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

FactoryGirl.define do
  factory :project do
    name "MyString"
    description "MyText"
    url "MyString"
    due_date "2013-02-06"
    published false
  end
end
