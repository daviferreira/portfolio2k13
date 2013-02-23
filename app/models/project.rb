class Project < ActiveRecord::Base
  attr_accessible :description, :due_date, :name, :published, :url, :category_id, :tags

  translates :name, :description, :tags
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes

  belongs_to :category
  has_many :photos

  validates :name, presence: true, length: { maximum: 140 }
  validates_presence_of :description, :url, :due_date
  validates :category, presence: true

  default_scope order: "projects.due_date DESC"
  scope :published, :conditions => { :published => true }, :order => "projects.due_date DESC"
end
