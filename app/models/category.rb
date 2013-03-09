class Category < ActiveRecord::Base
  attr_accessible :name

  translates :name
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes

  is_sluggable :name
  attr_accessible :cached_slug # for import only

  has_many :projects

  validates :name, presence: true, length: { maximum: 40 }

  default_scope order: "categories.name ASC" 
end
