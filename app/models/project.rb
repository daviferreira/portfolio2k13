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
end
