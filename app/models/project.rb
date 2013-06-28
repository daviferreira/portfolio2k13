class Project < ActiveRecord::Base
  attr_accessible :description, :due_date, :name, :published, :url,
                  :category_id, :tags, :cached_slug, :translations_attributes

  is_sluggable :name, { :use_cache => false }

  translates :name, :description, :tags, :cached_slug
  accepts_nested_attributes_for :translations

  belongs_to :category
  has_many :photos

  validates :name, presence: true, length: { maximum: 140 }
  validates_presence_of :description, :due_date
  validates :category, presence: true

  default_scope order: "projects.due_date DESC"
  scope :published, :conditions => { :published => true }, :order => "projects.due_date DESC"

  def get_by_tag(tag)
    if I18n.locale != I18n.default_locale
      Project.published.with_translations(I18n.locale).where(["project_translations.tags LIKE :tag", {:tag => "%#{tag}%"}]).group_by{|v| v.due_date.year}
    else
      Project.published.with_translations(I18n.locale).where(["projects.tags LIKE :tag", {:tag => "%#{tag}%"}]).group_by{|v| v.due_date.year}
    end
  end

  def get_localized(id)
    if I18n.locale != I18n.default_locale
      Project.find_by_cached_slug id
    else
      Project.find_using_slug id
    end
  end

  def get_metas
    [self.name, "#{self.description} - #{self.tags}"]
  end
end
