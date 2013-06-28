class Project < ActiveRecord::Base
  attr_accessible :description, :due_date, :name, :published, :url,
                  :category_id, :tags, :cached_slug, :translations_attributes
  delegate :name, :to => :category, :prefix => true

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
    locale = I18n.locale
    published_projects = Project.published.with_translations(locale)
    if locale != I18n.default_locale
      params = ["project_translations.tags LIKE :tag", {:tag => "%#{tag}%"}]
    else
      params = ["projects.tags LIKE :tag", {:tag => "%#{tag}%"}]
    end
    published_projects.where(params).group_by{|project| project.due_date.year}
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
