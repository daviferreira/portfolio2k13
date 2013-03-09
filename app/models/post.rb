class Post < ActiveRecord::Base
  attr_accessible :abstract, :block_comments, :body, :external_url,
                  :meta_description, :meta_title, :published, :published_date, 
                  :title, :tags, :locale

  is_sluggable :title
  attr_accessible :cached_slug # for import only

  validates_presence_of :title, :abstract, :body
end
