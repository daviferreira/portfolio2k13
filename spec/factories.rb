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
    due_date Time.now
    published false
    tags "tag1, tag2"
    cached_slug "test-project"
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
    external_url ''
    block_comments false
    locale I18n.locale
  end
end

FactoryGirl.define do
  factory :page do
    title "Test Page"
    body "This is a test page"
    published true
    cached_slug "test-page"
    meta_title "Page Meta Title"
    meta_description "Page Meta Description"
  end
end

FactoryGirl.define do
  factory :open_source_project do
    title "Test Project"
    description "This is a test project"
    url "http://www.daviferreira.com"
  end
end
