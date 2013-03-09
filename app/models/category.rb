class Category < ActiveRecord::Base
  attr_accessible :name

  translates :name
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes

  is_sluggable :name

  has_many :projects

  validates :name, presence: true, length: { maximum: 40 }

  default_scope order: "categories.name ASC" 
end
