class Photo < ActiveRecord::Base
  attr_accessible :order, :project_id, :title, :file
  belongs_to :project
  delegate :name, :to => :project, :prefix => true
  delegate :url, :to => :file, :prefix => true

  translates :title
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes

  has_attached_file :file, :styles => {:medium => "400x400#",
                                       :thumb => "80x80#",
                                       :highlight => "374x242#"}

  validates :title, presence: true, length: { maximum: 140 }
  validates_presence_of :order
  validates_numericality_of :order, only_integer: true
  validates :project, presence: true
  validates :file, :attachment_presence => true
end
