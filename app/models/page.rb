class Page < ActiveRecord::Base
  attr_accessible :body, :meta_description, :meta_title, :published, :title, :translations_attributes

  is_sluggable :title

  translates :title, :body, :meta_title, :meta_description, :cached_slug
  accepts_nested_attributes_for :translations

  validates_presence_of :title, :body
end
