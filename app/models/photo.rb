class Photo < ActiveRecord::Base
  attr_accessible :order, :project_id, :title, :file
  belongs_to :project

  has_attached_file :file, :styles => { :medium => "400x400#", :thumb => "80x80#" }

  validates :title, presence: true, length: { maximum: 140 }
  validates_presence_of :order
  validates_numericality_of :order, only_integer: true
  validates :project, presence: true
end
