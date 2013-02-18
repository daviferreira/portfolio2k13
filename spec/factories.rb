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
    category
  end
end

FactoryGirl.define do
  factory :photo do
    title "Photo"
    file File.new(Rails.root + 'spec/fixtures/images/rails.png')
    order 1
    project
  end
end

FactoryGirl.define do
  factory :post do
    title "Post"
    abstract "Post abstract"
    body "Post body"
    published true
    published_date Time.now
    meta_title "Post Meta Title"
    meta_description "Post Meta Description"
    external_url nil
    block_comments false
  end
end
