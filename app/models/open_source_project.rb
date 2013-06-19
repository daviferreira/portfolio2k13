class OpenSourceProject < ActiveRecord::Base
  attr_accessible :description, :title, :url, :file, :translations_attributes

  has_attached_file :file, :styles => {:medium => "400x400#",
                                       :thumb => "118x118#"}

  translates :title, :description
  accepts_nested_attributes_for :translations

  validates :title, presence: true, length: { maximum: 140 }
end
