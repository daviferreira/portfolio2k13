class Project < ActiveRecord::Base
  attr_accessible :description, :due_date, :name, :published, :url

  validates :name, presence: true, length: { maximum: 140 }
  validates_presence_of :description, :url, :due_date

  default_scope order: 'projects.due_date DESC'
  scope :published, :conditions => { :published => true }, :order => 'projects.due_date DESC'
end
