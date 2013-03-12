class Photo < ActiveRecord::Base
  attr_accessible :order, :project_id, :title, :file
  belongs_to :project

  translates :title
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes

  has_attached_file :file, :styles => {:medium => "400x400#",
                                       :thumb => "80x80#",
                                       :highlight => "276x240#"}

  validates :title, presence: true, length: { maximum: 140 }
  validates_presence_of :order
  validates_numericality_of :order, only_integer: true
  validates :project, presence: true
  validates :file, :attachment_presence => true
end
