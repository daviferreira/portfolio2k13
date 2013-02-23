class Post < ActiveRecord::Base
  attr_accessible :abstract, :block_comments, :body, :external_url,
                  :meta_description, :meta_title, :published, :published_date, 
                  :title, :tags

  translates :title, :abstract, :body, :tags
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes

  validates_presence_of :title, :abstract, :body
end
