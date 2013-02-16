class Photo < ActiveRecord::Base
  attr_accessible :order, :project_id, :title
  belongs_to :project

  validates :title, presence: true, length: { maximum: 140 }
  validates_presence_of :order
  validates_numericality_of :order, only_integer: true
  validates :project, presence: true
end
