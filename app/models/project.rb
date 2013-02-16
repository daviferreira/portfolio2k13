class Project < ActiveRecord::Base
  attr_accessible :description, :due_date, :name, :published, :url, :category_id

  belongs_to :category
  has_many :photos

  validates :name, presence: true, length: { maximum: 140 }
  validates_presence_of :description, :url, :due_date, :category_id

  default_scope order: "projects.due_date DESC"
  scope :published, :conditions => { :published => true }, :order => "projects.due_date DESC"
end
