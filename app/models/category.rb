class Category < ActiveRecord::Base
  attr_accessible :name, :cached_slug, :translations_attributes

  translates :name, :cached_slug
  accepts_nested_attributes_for :translations

  is_sluggable :name, { :use_cache => false }

  has_many :projects

  validates :name, presence: true, length: { maximum: 40 }

  default_scope order: "categories.name ASC" 

  def get_localized(id)
    if I18n.locale != I18n.default_locale
      Category.find_by_cached_slug id
    else
      Category.find_using_slug id
    end
  end
end
