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
  factory :category do
    name "Test Category"
  end
end

FactoryGirl.define do
  factory :project do
    name "Test Project"
    description "This is a test project"
    url "http://www.daviferreira.com"
    due_date "2013-02-06"
    published false
    category FactoryGirl.create(:category)
  end
end
