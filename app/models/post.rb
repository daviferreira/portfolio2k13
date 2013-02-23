class Post < ActiveRecord::Base
  attr_accessible :abstract, :block_comments, :body, :external_url,
                  :meta_description, :meta_title, :published, :published_date, 
                  :title, :tags, :locale

  validates_presence_of :title, :abstract, :body
end
