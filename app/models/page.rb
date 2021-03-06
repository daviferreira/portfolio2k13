class Page < ActiveRecord::Base
  attr_accessible :body, :meta_description, :meta_title, :published, :title,
                  :translations_attributes

  is_sluggable :title, { :use_cache => false }


  translates :title, :body, :meta_title, :meta_description, :cached_slug
  accepts_nested_attributes_for :translations

  validates_presence_of :title, :body
  scope :published, :conditions => { :published => true }

  def get_localized(id)
    if I18n.locale != I18n.default_locale
      Page.published.find_by_cached_slug id
    else
      Page.published.find_using_slug id
    end
  end

  def get_metas
    [self.meta_title || I18n.t("meta.title"),
     self.meta_description || I18n.t("meta.description")]
  end

  def get_sidebar
    if I18n.locale != I18n.default_locale
      sidebar = Page.published.find_by_cached_slug "sidebar-#{self.cached_slug}"
    else
      sidebar = Page.published.find_using_slug "sidebar-#{self.cached_slug}"
    end
    if sidebar.nil?
      ''
    else
      sidebar.body
    end
  end
end
