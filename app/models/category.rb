class Category < ActiveRecord::Base
  attr_accessible :name, :cached_slug, :translations_attributes

  translates :name, :cached_slug
  accepts_nested_attributes_for :translations

  is_sluggable :name

  has_many :projects

  validates :name, presence: true, length: { maximum: 40 }

  default_scope order: "categories.name ASC" 
end
